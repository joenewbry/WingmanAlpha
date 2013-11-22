//
//  DeactivateViewController.m
//  Syft
//
//  Created by Joe Newbry on 11/21/13.
//  Copyright (c) 2013 Joe Newbry. All rights reserved.
//

#import "DeactivateViewController.h"


@interface DeactivateViewController ()
@property (strong, nonatomic) IBOutlet UIPickerView *reasonForLeavingPicker;
@property (strong, nonatomic)          NSArray *optionsForLeavingArray;
@property(strong, nonatomic)           NSString *selectedReason;

@end

@implementation DeactivateViewController

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
    self.optionsForLeavingArray = [[NSArray alloc] initWithObjects:@"I met someone here!", @"I met someone elsewhere", @"Not enough people", @"Too many messages", @"Harassing messages", @"Too dificult to use", @"Breaks too much", @"Doesn't have my type"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)deleteAccountPressed:(id)sender {
    //[PFUser ]
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return (NSInteger)1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent: (NSInteger)component;
{
    return self.optionsForLeavingArray.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [self.optionsForLeavingArray objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.selectedReason = [self.optionsForLeavingArray objectAtIndex:row];
    NSLog(@"reason is that %@", self.selectedReason);
}

@end
