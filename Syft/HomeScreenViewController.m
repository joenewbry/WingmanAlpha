//
//  HomeScreenViewController.m
//  Syft
//
//  Created by Joe Newbry on 11/24/13.
//  Copyright (c) 2013 Joe Newbry. All rights reserved.
//

#import "HomeScreenViewController.h"
#import <Parse/Parse.h>
#import "Constants.h"

@interface HomeScreenViewController ()


// objects in story board to be set in code
@property (strong, nonatomic) IBOutlet UIProgressView *progressView;
@property (strong, nonatomic) IBOutlet UIImageView *userProfileView;
@property (strong, nonatomic) IBOutlet UILabel *usernameLabel;
@property (strong, nonatomic) IBOutlet UITableViewCell *profileCellView;
@property (strong, nonatomic) IBOutlet UITableViewCell *explorationCellView;
@property (strong, nonatomic) IBOutlet UITableViewCell *improveMatchesCellView;
@property (strong, nonatomic) IBOutlet UITableViewCell *settingsCellView;

// userdata from parse
@property NSArray *userData;

typedef enum {profileName, profileImage} UserData;

@end

@implementation HomeScreenViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self flipHiddenPropertyOnCells];
    [self downloadUserData];
    [self.progressView setProgress:100.0 animated:YES];
}

- (void) flipHiddenPropertyOnCells
{
    self.profileCellView.hidden = !self.profileCellView.hidden;
    self.explorationCellView.hidden = !self.explorationCellView.hidden;
    self.improveMatchesCellView.hidden = !self.improveMatchesCellView.hidden;
    self.settingsCellView.hidden = !self.settingsCellView.hidden;
}

- (void)downloadUserData
{
    PFQuery *query = [PFQuery queryWithClassName:user_data];
    [query whereKey:user_name containsString:[PFUser currentUser].username];

    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error){
        if (!error){

            NSArray *userData = [[NSArray alloc] initWithArray:objects];
            [self processUserData:userData];
            [self flipHiddenPropertyOnCells];
        } else {
            NSLog(@"%@", error.description);
        }
    }];
}

- (void)processUserData:(NSArray *)userData
{
    self.usernameLabel.text = [userData[profileName] objectForKey:user_name];
    NSData *profilePicture = [userData[profileName] objectForKey:user_profile_image];
    self.userProfileView.image = [[UIImage alloc] initWithData:profilePicture];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */
- (IBAction)logoutButtonPressed:(id)sender {
    [PFUser logOut];
    [self performSegueWithIdentifier:@"LogOut" sender:self];
}

@end
