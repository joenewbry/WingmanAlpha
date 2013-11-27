//
//  JoinUsViewController.m
//  Syft
//
//  Created by Joe Newbry on 11/18/13.
//  Copyright (c) 2013 Joe Newbry. All rights reserved.
//

#define basic_cell_identifier @"basicProfileInfo"

#import "JoinUsViewController.h"
#import "SignUpViewController.h"

@interface JoinUsViewController ()

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSDictionary *tableData;
@property (strong, nonatomic) NSArray *numberToKeys;
@property (strong, nonatomic) NSMutableDictionary *userData;
@property (strong, nonatomic) NSMutableArray *selectedCells;

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
    // define table data

    [self defineData];
    [self configureTableView];
}

- (void) defineData
{
    self.tableData = @{@"Gender" : @[@"I'm Female", @"I'm Male"], @"Orientation": @[@"Straight", @"Gay", @"Bisexual"]};
    self.numberToKeys = @[@"Gender", @"Orientation"];
    self.userData = [[NSMutableDictionary alloc] init];
    [self.userData setValue:@0 forKey:@"Gender"];
    [self.userData setValue:@0 forKey:@"Orientation"];

    self.selectedCells = [[NSMutableArray alloc] initWithArray:@[@0, @0]];

    
}

- (void)configureTableView
{
    // make view fit tableview bounds
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 40, self.view.frame.size.width, 350) style:UITableViewStyleGrouped];
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    // configure table view
    self.tableView.scrollEnabled = false;

    [self.view addSubview:self.tableView];

    // fill in table
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView reloadData];

    // resize tableView to fit content
    CGRect frame = self.tableView.frame;
    frame.size.height = self.tableView.contentSize.height;
    self.tableView.frame = frame;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark loading table view data
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.tableData count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  [[self.tableData objectForKey:self.numberToKeys[section]] count];
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    // The header for the section is the region name -- get this from the region at the section index.
    return self.numberToKeys[section];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:basic_cell_identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:basic_cell_identifier];
    }
    if (self.selectedCells[indexPath.section] == [NSNumber numberWithInteger:indexPath.row]){
        [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
    } else {
        [cell setAccessoryType:UITableViewCellAccessoryNone];
    }
    cell.textLabel.text = [self.tableData objectForKey:self.numberToKeys[indexPath.section]][indexPath.row];
    return cell;
}

#pragma mark table view handle touch events
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedCells[indexPath.section] = [NSNumber numberWithInteger:indexPath.row];
    [[tableView cellForRowAtIndexPath:indexPath] setAccessoryType:UITableViewCellAccessoryCheckmark];

    [self.userData setValue:[NSNumber numberWithInteger:indexPath.row] forKey:self.numberToKeys[indexPath.section]];
    [self.tableView reloadData];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"toSignUp"]){
        SignUpViewController *targetView = segue.destinationViewController;
        [targetView passUserObject:self.userData];
    }
}


@end
