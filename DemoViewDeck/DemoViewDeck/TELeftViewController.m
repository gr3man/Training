//
//  TELeftViewController.m
//  DemoViewDeck
//
//  Created by Tuấn Nguyễn Anh on 7/4/13.
//  Copyright (c) 2013 Tuấn Nguyễn Anh. All rights reserved.
//

#import "TELeftViewController.h"
#import "TEDisclosureViewController.h"
#import "TECheckListViewController.h"
#import "TEPrensentViewController.h"
#import "TEImageViewController.h"
#import "TEMoveViewController.h"

@interface TELeftViewController ()

@end

BOOL haveRightMenu;
@implementation TELeftViewController
@synthesize menuDelegate, menus;

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
    NSArray *temps;
    
    temps = @[[[TEDisclosureViewController alloc] init],
              [[TECheckListViewController alloc] init],
              [[TEPrensentViewController alloc] init],
              [[TEImageViewController alloc] init],
              [[TEMoveViewController alloc] init]];
    
    rightMenu = [[TERightViewController alloc] init];
    self.viewDeckController.rightController = rightMenu;
    rightMenu.labelDetail.text = [NSString stringWithFormat:@"This is detail for %@", self.viewDeckController.centerController.title];
    haveRightMenu = YES;
    
    menus = [[NSMutableArray alloc] initWithCapacity:[temps count]];
    
    for (int i = 0; i < [temps count]; i++) {
        UIViewController* tempController = temps[i];
        tempController = [[UINavigationController alloc] initWithRootViewController:tempController];
        [menus addObject:tempController];
    }
}

- (void) viewDidDisappear:(BOOL)animated
{
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
    if (haveRightMenu) {
        self.viewDeckController.rightController = rightMenu;
    } else {
        self.viewDeckController.rightController = nil;
    }
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

- (void) handleRightMenu
{
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //self.viewDeckController.centerController = menus[indexPath.row];
    [self.viewDeckController closeOpenView];
    self.viewDeckController.centerController = menus[indexPath.row];
    rightMenu.labelDetail.text = [NSString stringWithFormat:@"This is detail for %@", self.viewDeckController.centerController.title];
    
    if (indexPath.row == 2 || indexPath.row == 4) {
        haveRightMenu = NO;
    } else {
        haveRightMenu = YES;
    }
}

@end
