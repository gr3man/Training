//
//  TELeftViewController.m
//  DemoViewDeck
//
//  Created by Tuấn Nguyễn Anh on 7/4/13.
//  Copyright (c) 2013 Tuấn Nguyễn Anh. All rights reserved.
//

#import "TELeftViewController.h"

@interface TELeftViewController ()

@end

NSString *tempText;
@implementation TELeftViewController
@synthesize menuDelegate;

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
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self.tableView setFrame:CGRectMake(self.tableView.frame.origin.x, self.tableView.frame.origin.y, 400, self.tableView.frame.size.height)];
    [self.tableView setBackgroundColor:[UIColor lightGrayColor]];
    self.tableView.backgroundView = nil;
    [self.view setBackgroundColor:self.tableView.backgroundColor];
    number = @[@"one",@"two",@"three",@"four",@"five"];
}

- (void) viewDidDisappear:(BOOL)animated
{
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 5;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"Team menu";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png",number[indexPath.row]]];
    cell.imageView.image = image;
    cell.textLabel.text = [NSString stringWithFormat:@"menu %d", indexPath.row];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"select menu %d", indexPath.row];
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    tempText = [tableView cellForRowAtIndexPath:indexPath].textLabel.text;
    [menuDelegate didSelectMenu:tempText];
}

@end
