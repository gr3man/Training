//
//  TEViewController.m
//  Exercise5_3
//
//  Created by Tuấn Nguyễn Anh on 5/2/13.
//  Copyright (c) 2013 Tuấn Nguyễn Anh. All rights reserved.
//

#import "TEViewController.h"
#import "TEPickerData.h"
#import "TECustomPicker.h"

@interface TEViewController ()

@end

@implementation TEViewController
int selectedMonth;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    rowFields = @[@"Start",@"End"];
    selectionFields = @[@"Selected Date"];
    data = [[TEPickerData alloc] init];
    self.picker = [[TECustomPicker alloc] init];
    [self.picker setDelegate:self];
    [self.picker setDataSource:self];
    [self.picker setMonths:data.month];
    [self.picker setDateOfMonth:data.dayOfMonth];
    [self.picker setYear:data.year];
    [self.picker setType:2];
    selectedMonth = 0;
    //TEPickerViewController *tep = [[TEPickerViewController alloc] init];
    //[self.view addSubview:tep.view];
    //[tep test:self.view];
    //NSString *d = a[@"February"];
}

#pragma mark -
#pragma mark Picker Data Source Methods
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return [self.picker type];
}

- (NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if(component == kDateComponent){
        int numberDate = [data.month[selectedMonth][1] integerValue];
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
        selectedMonth = row;
        [self.picker reloadComponent:kDateComponent];
    }
    else if (component == kYearComponent){
        NSInteger valueYear = [data.year[row] integerValue];
        if(((valueYear % 4 == 0) && (valueYear % 100 != 0)) || (valueYear % 400 ==0)){
            [data.month replaceObjectAtIndex:1 withObject:@[@"February",@"29"]];
            [self.picker reloadComponent:kDateComponent];
        }
        else{
            [data.month replaceObjectAtIndex:1 withObject:@[@"February",@"28"]];
            [self.picker reloadComponent:kDateComponent];
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
    //check if this our table view
    if ([tableView isEqual:self.table]){
        static NSString *TableViewCellIdentifier = @"Cells";
        cell = [tableView dequeueReusableCellWithIdentifier:TableViewCellIdentifier];
        if (cell == nil){
            cell = [[UITableViewCell alloc]
                    initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:TableViewCellIdentifier];
        }
        
        //set the text for the cell with the data from the array
        
        cell.textLabel.text = rowFields[indexPath.row];
        //NSInteger day = temp[@""];
        if(self.picker.type == 2){
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ %@",data.month[0][0],data.dayOfMonth[0]];
        }
        else {
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ %@ %@",data.month[0][0],data.dayOfMonth[0], data.year[0]];
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *targetCell = [tableView cellForRowAtIndexPath:indexPath];
    [self.picker addActionSheet:self.view withCell:targetCell];
    //[self.view addSubview:self.picker];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
