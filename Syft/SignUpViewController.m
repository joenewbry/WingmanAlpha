//
//  SignUpViewController.m
//  Syft
//
//  Created by Joe Newbry on 11/21/13.
//  Copyright (c) 2013 Joe Newbry. All rights reserved.
//

#import "SignUpViewController.h"
#import <Parse/Parse.h>
#import "Constants.h"

@interface SignUpViewController ()
@property (strong, nonatomic) IBOutlet UITextField *emailAddress;
@property (strong, nonatomic) IBOutlet UITextField *username;
@property (strong, nonatomic) IBOutlet UITextField *password;

@property (strong, nonatomic) NSMutableDictionary *userData;


@end

@implementation SignUpViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.

    // Check if a user is cached
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];

    self.username.delegate = self;
    self.emailAddress.delegate = self;
    self.password.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)submitButtonPressed:(id)sender {
    
    [self signIn];
    [self saveUserProfile];
}

- (void)signIn
{
    PFUser *user = [PFUser user];
    user.username = self.username.text;
    user.email = self.emailAddress.text;
    user.password = self.password.text;

    //if (user)

    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (error) {
            //Something bad has ocurred
            NSString *errorString = [[error userInfo] objectForKey:@"error"];
            UIAlertView *errorAlertView = [[UIAlertView alloc] initWithTitle:@"Error" message:errorString delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [errorAlertView show];
        } else {
            //The registration was succesful, go to the wall
            [self saveUserProfile];
            [self performSegueWithIdentifier:@"toHomeScreen" sender:self];
        }
    }];
}

- (void)saveUserProfile
{
    // create a PFObject and store the basics of the profile
    PFObject *userProfile = [PFObject objectWithClassName:user_data];
    [userProfile setObject:[PFUser currentUser].username forKey:user_name];
    for (id key in self.userData){
        [userProfile setObject:[self.userData valueForKey:key] forKey:key];
    }
    UIImage *defaultProfile = [UIImage imageNamed:@"user_circle.png"];
    NSData *profileData = UIImagePNGRepresentation(defaultProfile);

    [userProfile setObject:profileData  forKey:user_profile_image];
        [userProfile saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!succeeded){
            NSString *errorString = [[error userInfo] objectForKey:@"error"];
                [self showErrorView:errorString];
            }
        }];
}

// might use later
-(NSData*)compressImageFromNSData:(NSData *)data
{
    // Convert NSData to UIImage, compress and convert back to NSData
    UIImage *image = [UIImage imageWithData:data];

    UIGraphicsBeginImageContext(CGSizeMake(640, 960));
    [image drawInRect:CGRectMake(0, 0, 640, 960)];
    UIImage *compressedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    NSData *imageData = UIImagePNGRepresentation(compressedImage);
    return imageData;
}

- (void)passUserObject:(NSMutableDictionary *)data
{
    self.userData = data;
}

-(void)addSpinner
{
    UIActivityIndicatorView *loadingSpinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];

    [loadingSpinner setCenter:CGPointMake(self.view.frame.size.width/2.0, self.view.frame.size.height/2.0)];
    [loadingSpinner startAnimating];
    [self.view addSubview:loadingSpinner];
}

# pragma mark HANDLE TEXT INPUT
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (self.username.text.length > 0 && self.emailAddress.text.length > 0 && self.password.text.length > 0){
        [textField resignFirstResponder];
        //[self signUpPressed:nil];
    }
    else if (textField.tag == 0){
        [self.emailAddress becomeFirstResponder];
    } else if (textField.tag == 1){
        [self.password becomeFirstResponder];
    }
    else {
        [self.username becomeFirstResponder];
    }
    return NO;
}

- (void)dismissKeyboard
{
    [self.emailAddress resignFirstResponder];
    [self.username resignFirstResponder];
    [self.password resignFirstResponder];
}

-(void)showErrorView:(NSString *)errorMsg
{
    UIAlertView *errorAlertView = [[UIAlertView alloc] initWithTitle:@"Error" message:errorMsg delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [errorAlertView show];
}



@end
