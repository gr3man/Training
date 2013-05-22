//
//  TEViewController.m
//  Exercise5_2
//
//  Created by Tuan Nguyen Anh on 4/16/13.
//  Copyright (c) 2013 Tuan Nguyen Anh. All rights reserved.
//

#import "TEViewController.h"

NSInteger numberDay = 31;
NSInteger dateSelected = 0;

@interface TEViewController ()

@end

@implementation TEViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.rowFields = @[@"Start",@"End"];
    self.selectionFields = @[@"Selected Date"/*,@"Selected Time"*/];
    self.dateOfMonth = [[NSMutableArray alloc] init];
    
    for(int i = 1; i<=31; i++){
        [self.dateOfMonth addObject:[NSString stringWithFormat:@"%d",i]];
    }
    self.month = @[@"January",@"February",@"March",@"April",@"May",@"June",@"July",@"August",@"September",@"October",@"November",@"December"];
//    
//    self.dateFormat = [[NSDateFormatter alloc] init];
//    [self.dateFormat setDateStyle:NSDateFormatterFullStyle];
//    [self.dateFormat setTimeStyle:NSDateFormatterNoStyle];
//    
//    self.timeFormat = [[NSDateFormatter alloc] init];
//    [self.timeFormat setDateStyle:NSDateFormatterNoStyle];
//    [self.timeFormat setTimeStyle:NSDateFormatterMediumStyle];
    self.picker = [[UIPickerView alloc] init];
    self.picker.dataSource = self;
    self.picker.delegate = self;
    self.picker.showsSelectionIndicator = YES;

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.selectionFields count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.rowFields count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return self.selectionFields[section];
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = nil;
    //check if this our table view
    if ([tableView isEqual:self.tableView]){
        static NSString *TableViewCellIdentifier = @"Cells";
        cell = [tableView dequeueReusableCellWithIdentifier:TableViewCellIdentifier];
        if (cell == nil){
            cell = [[UITableViewCell alloc]
                    initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:TableViewCellIdentifier];
        }
        
        //set the text for the cell with the data from the array

        cell.textLabel.text = self.rowFields[indexPath.row];
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ %@",self.month[0],self.dateOfMonth[0]];
        
        //depending on the row set the date to current date with the proper format
    }
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *targetCell = [tableView cellForRowAtIndexPath:indexPath];
    //if date picker doesn't exists then create it
    //NSDate *Date=[];
    //UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:1];
    //NSLog([NSString stringWithFormat:@"%@",cell.textLabel.text]);
    //set the value of the picker based on the cell value and also set the proper picker mode
    
    
    //find the current table view size
    //CGRect screenRect = [self.view frame];
    //find the date picker size
    CGSize pickerSize = [self.picker sizeThatFits:CGSizeZero];
    
    //set the picker frame
    CGRect pickerRect = self.picker.frame;
    if(self.menu == nil){
        self.menu = [[UIActionSheet alloc] initWithTitle:nil
                                                delegate:self
                                       cancelButtonTitle:nil
                                  destructiveButtonTitle:nil
                                       otherButtonTitles:nil];
    }
    
    //UIDatePicker *pickerView = [[UIDatePicker alloc] init];
    //pickerView.datePickerMode = UIDatePickerModeDate;
    
    //self.pickerToolbar = [[UIToolbar alloc] initWithFrame: CGRectMake(0, 0, self.view.frame.size.width, 50)];
    //[self.pickerToolbar setItems:barItems animated:YES];
    //self.picker.
    
    NSArray *listItems = [targetCell.detailTextLabel.text componentsSeparatedByString:@" "];
    NSInteger indexMonth = [self.month indexOfObject:listItems[0]];
    NSInteger indexDate = [listItems[1] integerValue];
    
    numberDay = [self checkDayOfMonth:indexMonth+1];
    [self.picker reloadComponent:kDateComponent];
    //[self.picker
    
    [self.picker selectRow:indexMonth inComponent:kMonthComponent animated:YES];
    [self.picker selectRow:indexDate-1 inComponent:kDateComponent animated:YES];
    
    [self.doneButton setFrame:CGRectMake(self.view.frame.size.width - self.doneButton.frame.size.width - 10, 13, self.doneButton.frame.size.width, self.doneButton.frame.size.height)];
    [self.doneButton  addTarget:self action:@selector(dateSelected:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.menu addSubview:self.doneButton];
    [self.menu addSubview:self.picker];
    [self.menu showInView:self.view];
    
    CGRect menuRect = self.menu.frame;
    CGFloat orgHeight = menuRect.size.height + self.doneButton.frame.size.height;
    menuRect.origin.y -= pickerSize.height + self.doneButton.frame.size.height; //height of picker
    menuRect.size.height = orgHeight+pickerRect.size.height + self.doneButton.frame.size.height;
    
    self.menu.frame = menuRect;
    pickerRect.origin.y = orgHeight;
    self.picker.frame = pickerRect;
}

- (void) dateSelected:(id)sender {
    
    //find the current selected cell row in the table view
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    UITableViewCell *cellSelect = [self.tableView cellForRowAtIndexPath:indexPath];
    //set the cell value from the date picker value and format it properly
    NSInteger monthRow = [self.picker selectedRowInComponent:kMonthComponent];
    NSInteger dateRow = [self.picker selectedRowInComponent:kDateComponent];
    
    NSString *day = self.dateOfMonth[dateRow];
    NSString *month = self.month[monthRow];
    
    cellSelect.detailTextLabel.text = [NSString stringWithFormat:@"%@ %@",month, day];
    //remove the date picker view form the super view
    [self.menu dismissWithClickedButtonIndex:0 animated:YES];
    
    //deselect the current table row
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark -
#pragma mark Picker Data Source Methods
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 2;
}

- (NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if(component == kDateComponent){
        return numberDay;
    }else{
        return [self.month count];
    }
}

#pragma mark Picker Delegate Methods
- (NSString *) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if(component == kDateComponent){
        return self.dateOfMonth[row];
    } else{
        return self.month[row];
    }
}

- (void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{

    if(component == kMonthComponent){
        numberDay = [self checkDayOfMonth:row+1];
        [self.picker reloadComponent:kDateComponent];
    }
//    if(component == kDateComponent){
//        dateSelected = [self.picker selectedRowInComponent:kDateComponent];
//        if(dateSelected+1>numberDay){
//            [self.picker selectRow:numberDay-1 inComponent:kDateComponent animated:YES];
//            //dateSelected++;
//        }
//    }
}

- (NSInteger) checkDayOfMonth:(NSInteger)month{
    switch (month) {
        case 4:
        case 6:
        case 9:
        case 11:
            return 30;
            break;
        case 2:
            return 28;
        default:
            return 31;
            break;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
