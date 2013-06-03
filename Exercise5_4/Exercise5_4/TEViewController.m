//
//  TEViewController.m
//  Exercise5_4
//
//  Created by Tuấn Nguyễn Anh on 5/15/13.
//  Copyright (c) 2013 Tuấn Nguyễn Anh. All rights reserved.
//

#import "TEViewController.h"

@interface TEViewController ()

@end

@implementation TEViewController
@synthesize selectionFields;
@synthesize rowFields;
@synthesize timeFormat;
@synthesize myTimePicker;
@synthesize myDatePicker;

static NSString *TableViewCellIdentifier = @"Cells";

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    rowFields = @[@"Start",@"End"];
    selectionFields = @[@"Selected Date",@"Selected Time"];
    data = [[TEPickerData alloc] init];
    
    timeFormat = [[NSDateFormatter alloc] init];
    [timeFormat setDateStyle:NSDateFormatterNoStyle];
    [timeFormat setTimeStyle:NSDateFormatterMediumStyle];
    
    myTimePicker = [[TEBasePicker alloc] init];
    myDatePicker = [[TECustomPicker alloc] init];
    timePicker = [[UIDatePicker alloc] init];
    datePicker = [[UIPickerView alloc] init];
    
    [myDatePicker setMonths:data.month];
    [myDatePicker setDateOfMonth:data.dayOfMonth];
    [myDatePicker setYear:data.year];
    [myDatePicker setType:2];
    [datePicker setDelegate:self];
    [datePicker setDataSource:self];
    [myDatePicker setDelegate:self];
    [myTimePicker setDelegate:self];
}

#pragma mark -
#pragma mark Picker Data Source Methods
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return [myDatePicker type];
}

- (NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if(component == kDateComponent){
        int numberDate = [data.month[myDatePicker.selectedMonth][1] integerValue];
        return numberDate;
    }else if (component == kMonthComponent){
        return [data.month count];
    }
    else{
        return [data.year count];
    }
}

#pragma mark Picker Delegate Methods
- (NSString *) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if(component == kDateComponent){
        return [NSString stringWithFormat:@"%d",row+1];
    } else if (component == kMonthComponent){
        return data.month[row][0];
    } else{
        return data.year[row];
    }
}

- (void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if(component == kMonthComponent){
        [myDatePicker setSelectedMonth:row];
        selectedMonth = row;
        [myDatePicker.picker reloadComponent:kDateComponent];
    }
    else if (component == kYearComponent){
        NSInteger valueYear = [data.year[row] integerValue];
        if(((valueYear % 4 == 0) && (valueYear % 100 != 0)) || (valueYear % 400 ==0)){
            [data.month replaceObjectAtIndex:1 withObject:@[@"February",@"29"]];
            [myDatePicker.picker reloadComponent:kDateComponent];
        }
        else{
            [data.month replaceObjectAtIndex:1 withObject:@[@"February",@"28"]];
            [myDatePicker.picker reloadComponent:kDateComponent];
        }
    }
}

- (CGFloat) pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    switch (component) {
        case kDateComponent:
            return 70;
        case kMonthComponent:
            return 120;
        case kYearComponent:
            return 90;
        default:
            return 0;
            break;
    }
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [selectionFields count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [rowFields count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return selectionFields[section];
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = nil;
    TableViewCellIdentifier = @"Cells";
    cell = [tableView dequeueReusableCellWithIdentifier:TableViewCellIdentifier];
    if (cell == nil){
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:TableViewCellIdentifier];
        
        //NSDateComponents *timeComp = [gregorian components:(NSHourCalendarUnit | NSMinuteCalendarUnit | NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit) fromDate:[NSDate date]];
        
        if(indexPath.section == 1){
            cell.detailTextLabel.text = [timeFormat stringFromDate:[NSDate date]];
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ %@",data.month[0][0],data.dayOfMonth[0]];
        }
        
    }
    
    cell.textLabel.text = self.rowFields[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *targetCell = [tableView cellForRowAtIndexPath:indexPath];    
    if(indexPath.section == 1){
        if(myTimePicker.picker == nil){
            timePicker.datePickerMode = UIDatePickerModeTime;
            myTimePicker.picker = (UIPickerView *) timePicker;
        }
        timePicker.date = [self.timeFormat dateFromString:targetCell.detailTextLabel.text];
        [myTimePicker addActionSheet:self.view withCell:targetCell];
    } else if (indexPath.section == 0){
        if(myDatePicker.picker == nil){
            myDatePicker.picker = datePicker;
        }
        [myDatePicker addActionSheet:self.view withCell:targetCell];
    }
    
}

- (void)setCellString:(NSString *)stringSet{
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    UITableViewCell *targetCell = [self.tableView cellForRowAtIndexPath:indexPath];
    targetCell.detailTextLabel.text = stringSet;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
