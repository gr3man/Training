//
//  TEViewController.m
//  Exercise4
//
//  Created by Tuan Nguyen Anh on 4/9/13.
//  Copyright (c) 2013 Tuan Nguyen Anh. All rights reserved.
//

#import "TEViewController.h"
#import "TELoginCell.h"

@interface TEViewController ()

@end

@implementation TEViewController

static NSString *CellTableIdentifier = @"Cell";

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        self.texts = @[
                       @{@"label":@"Name", @"placeHolder":@"John AppleSeed"},
                       @{@"label":@"Address", @"placeHolder":@"example@gmail.com"},
                       @{@"label":@"Password", @"placeHolder":@"Required"},
                       @{@"label":@"Description", @"placeHolder":@"My Gmail Account"}];
    }
    UINib *nib = [UINib nibWithNibName:@"TELoginCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:CellTableIdentifier];
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.tableView.allowsSelection=NO;
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.texts count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TELoginCell *cell = [tableView dequeueReusableCellWithIdentifier:CellTableIdentifier forIndexPath:indexPath];
    
    NSDictionary *dic = self.texts[indexPath.row];
    // Configure the cell...
    cell.labelView.text = dic[@"label"];
    cell.textView.placeholder = dic[@"placeHolder"];
    return cell;
}

- (IBAction)backgroundTap:(id)sender{
    TELoginCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellTableIdentifier];
    [cell.labelView resignFirstResponder];
    [cell.textView resignFirstResponder];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
