//
//  TEViewController.m
//  Exercise5
//
//  Created by Tuan Nguyen Anh on 4/15/13.
//  Copyright (c) 2013 Tuan Nguyen Anh. All rights reserved.
//

#import "TEViewController.h"

NSDate *minDate;
NSDate *beginDate;

@interface TEViewController ()

@end

@implementation TEViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.rowFields = @[@"Start",@"End"];
    self.selectionFields = @[@"Selected Date",@"Selected Time"];
    
    self.dateFormat = [[NSDateFormatter alloc] init];
    [self.dateFormat setDateStyle:NSDateFormatterFullStyle];
    [self.dateFormat setTimeStyle:NSDateFormatterNoStyle];
    
    self.timeFormat = [[NSDateFormatter alloc] init];
    [self.timeFormat setDateStyle:NSDateFormatterNoStyle];
    [self.timeFormat setTimeStyle:NSDateFormatterMediumStyle];
    
    //tableView = (id)[self.view viewWithTag:10];
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
        
        NSDateComponents *comps=[[NSDateComponents alloc] init];
        [comps setHour:0];
        [comps setMinute:0];
        [comps setSecond:0];
        [comps setDay:1];
        [comps setMonth:1];
        [comps setYear:1970];
        
        NSCalendar *gregorian = [[NSCalendar alloc]
                                 initWithCalendarIdentifier:NSGregorianCalendar];
        beginDate = [gregorian dateFromComponents:comps];
        
        //depending on the row set the date to current date with the proper format
        minDate = [[NSDate date] dateByAddingTimeInterval:60*60*24*1];
        switch (indexPath.section) {
            case 0:
                cell.detailTextLabel.text = [self.dateFormat stringFromDate:[NSDate date]];
                if(indexPath.row == 1){
                    cell.detailTextLabel.text = [self.dateFormat stringFromDate:minDate];
                }
                break;
            case 1:
                cell.detailTextLabel.text = [self.timeFormat stringFromDate:beginDate];
                break;
            default:
                break;
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *targetCell = [tableView cellForRowAtIndexPath:indexPath];
    //if date picker doesn't exists then create it
    if(self.myDatePicker == nil){
        self.myDatePicker = [[UIDatePicker alloc] init];
        
        //set the action method that will listen for changes to picker value
        [self.myDatePicker addTarget:self action:nil forControlEvents:UIControlEventValueChanged];
    }

    //NSDate *Date=[];
    //UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:1];
    //NSLog([NSString stringWithFormat:@"%@",cell.textLabel.text]);
    //set the value of the picker based on the cell value and also set the proper picker mode
    switch (indexPath.section) {
        case 0:
            self.myDatePicker.date = [self.dateFormat dateFromString:targetCell.detailTextLabel.text];
            self.myDatePicker.datePickerMode = UIDatePickerModeDate;
            if(indexPath.row == 1){
                self.myDatePicker.minimumDate = minDate;
            }
            else{
                self.myDatePicker.minimumDate = beginDate;
            }
            break;
        case 1:
            self.myDatePicker.date = [self.timeFormat dateFromString:targetCell.detailTextLabel.text];
            self.myDatePicker.datePickerMode = UIDatePickerModeTime;
            self.myDatePicker.minimumDate = beginDate;
            break;
        default:
            break;
    }
    
    //find the current table view size
    //CGRect screenRect = [self.view frame];
    //find the date picker size
    CGSize pickerSize = [self.myDatePicker sizeThatFits:CGSizeZero];
    
    //set the picker frame
    CGRect pickerRect = self.myDatePicker.frame;
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

    [self.doneButton setFrame:CGRectMake(self.view.frame.size.width - self.doneButton.frame.size.width - 10, 13, self.doneButton.frame.size.width, self.doneButton.frame.size.height)];
    [self.doneButton  addTarget:self action:@selector(dateSelected:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.menu addSubview:self.doneButton];
    [self.menu addSubview:self.myDatePicker];
    [self.menu showInView:self.view];
    
    CGRect menuRect = self.menu.frame;
    CGFloat orgHeight = menuRect.size.height + self.doneButton.frame.size.height;
    menuRect.origin.y -= pickerSize.height + self.doneButton.frame.size.height; //height of picker
    menuRect.size.height = orgHeight+pickerRect.size.height + self.doneButton.frame.size.height;
    
    self.menu.frame = menuRect;
    pickerRect.origin.y = orgHeight;
    self.myDatePicker.frame = pickerRect;
}

- (void) dateSelected:(id)sender {
    
    //find the current selected cell row in the table view
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    UITableViewCell *cellSelect = [self.tableView cellForRowAtIndexPath:indexPath];
    //set the cell value from the date picker value and format it properly
    switch (indexPath.section) {
        case 0:
            cellSelect.detailTextLabel.text = [self.dateFormat stringFromDate:self.myDatePicker.date];
            if(indexPath.row == 0){
                minDate = [self.myDatePicker.date dateByAddingTimeInterval:60*60*24*1];
                NSIndexPath *myIP = [NSIndexPath indexPathForRow:1 inSection:0];
                UITableViewCell *cellEnd = [self.tableView cellForRowAtIndexPath:myIP];
                NSDate *dateEnd = [self.dateFormat dateFromString:cellEnd.detailTextLabel.text];
                if([minDate compare:dateEnd] == NSOrderedDescending){//minDate sau dateEnd
                    cellEnd.detailTextLabel.text = [self.dateFormat stringFromDate:minDate];
                }
            }
            break;
        case 1:
            cellSelect.detailTextLabel.text = [self.timeFormat stringFromDate:self.myDatePicker.date];
            break;
        default:
            break;
    }
    
    //remove the date picker view form the super view
    [self.menu dismissWithClickedButtonIndex:0 animated:YES];
    
    //deselect the current table row
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
