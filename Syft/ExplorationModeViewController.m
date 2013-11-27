//
//  ExplorationModeViewController.m
//  Syft
//
//  Created by Joe Newbry on 11/26/13.
//  Copyright (c) 2013 Joe Newbry. All rights reserved.
//

#import "ExplorationModeViewController.h"

@interface ExplorationModeViewController ()
@property (strong, nonatomic) IBOutlet UISwitch *matchesSwitch;

@end

@implementation ExplorationModeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (IBAction)lookForMatchesTouched:(id)sender {
    if (self.matchesSwitch.on) {

    } else {
        // turn bluetooth off
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
