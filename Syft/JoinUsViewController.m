//
//  JoinUsViewController.m
//  Syft
//
//  Created by Joe Newbry on 11/18/13.
//  Copyright (c) 2013 Joe Newbry. All rights reserved.
//

#import "JoinUsViewController.h"

@interface JoinUsViewController ()

@end

@implementation JoinUsViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.

    NSMutableArray* ar = [[NSMutableArray alloc] initWithArray:@[@"stt", @"asdfs"]];

    return (NSUInteger) 2;// [ar count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Basic Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];

    if(cell == nil) {
        // Make sure to change the default style to the next one if you want to manage to display text
        // in the detailsTextLabel area.
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }

    // configure the cell (NOTHING HANDLED IN STORY BOARD)

    // Specify current row
    int currentRow = [indexPath row];

    [[cell textLabel] setText:[NSString stringWithFormat:@"test"]];//"%@", [self.tableData objectAtIndex:currentRow]]];//self.contactsArray[currentRow]]];

    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"Contacts";
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath
{

}

@end
