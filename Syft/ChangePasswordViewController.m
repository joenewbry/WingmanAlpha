//
//  ChangePasswordViewController.m
//  Syft
//
//  Created by Joe Newbry on 11/24/13.
//  Copyright (c) 2013 Joe Newbry. All rights reserved.
//

#import "ChangePasswordViewController.h"
#import <Parse/Parse.h>

@interface ChangePasswordViewController ()
@property (strong, nonatomic) IBOutlet UIButton *submitButton;

@end

@implementation ChangePasswordViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)submitButtonPressed:(id)sender {
    [PFUser requestPasswordResetForEmail:[PFUser currentUser].email];
    self.submitButton.backgroundColor = [UIColor greenColor];
    [self.submitButton setTitle:@"Password Reset Submitted" forState:UIControlStateNormal];
}


@end
