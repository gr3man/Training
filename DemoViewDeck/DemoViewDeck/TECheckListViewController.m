//
//  TECheckListViewController.m
//  DemoViewDeck
//
//  Created by Tuan Nguyen Anh on 7/7/13.
//  Copyright (c) 2013 Tuấn Nguyễn Anh. All rights reserved.
//

#import "TECheckListViewController.h"

@interface TECheckListViewController ()

@end

static NSString *CellIdentifier = @"Cell";

@implementation TECheckListViewController
@synthesize snacks;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        self.title = @"Menu 1";
        self.snacks = @[@"Who Hash", @"Bubba Gump Shrimp Étouffée",
                        @"Who Pudding", @"Scooby Snacks", @"Everlasting Gobstopper",
                        @"Green Eggs and Ham", @"Soylent Green", @"Hard Tack",
                        @"Lembas Bread", @"Roast Beast", @"Blancmange"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellIdentifier];
}

#pragma mark - Table View Data Source Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.snacks count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView
                             dequeueReusableCellWithIdentifier:CellIdentifier];
    cell.textLabel.text = self.snacks[indexPath.row];
    if (indexPath.row == 4) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setTableView:nil];
    [super viewDidUnload];
}
@end
