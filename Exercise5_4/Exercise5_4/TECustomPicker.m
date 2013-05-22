//
//  TECustomPicker.m
//  Exercise5_4
//
//  Created by Tuan Nguyen Anh on 5/19/13.
//  Copyright (c) 2013 Tuấn Nguyễn Anh. All rights reserved.
//

#import "TECustomPicker.h"

@implementation TECustomPicker
@synthesize picker;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setMonths:(NSMutableArray *)mon{
    months = mon;
}

- (void)setDateOfMonth:(NSMutableArray *)day{
    dateOfMonth = day;
}

- (void)setYear:(NSMutableArray *)newYear{
    year = newYear;
}

- (void)setType:(int)t{
    type = t;
}

- (int)type{
    return type;
}

- (int) selectedMonth{
    return selectedMonth;
}

- (void) setSelectedMonth:(int)selMon{
    selectedMonth = (int)selMon;
}

- (void) addActionSheet:(UIView *)view withCell:(UITableViewCell *)c
{
    NSInteger indexMonth = 0;
    NSArray *listItems = [c.detailTextLabel.text componentsSeparatedByString:@" "];
    //Tìm tháng theo chữ trong cell
    for (int i = 0; i < [months count]; i++) {
        if([months[i][0] isEqualToString:listItems[0]]){
            indexMonth = i;
            //Đặt tháng chọn là tháng tìm được
            selectedMonth = i;
            break;
        }
    }
    //Sau khi tìm được thì reload
    [picker reloadComponent:kDateComponent];
    NSInteger indexDate = [listItems[1] integerValue];
    [picker selectRow:indexMonth inComponent:kMonthComponent animated:YES];
    [picker selectRow:indexDate - 1 inComponent:kDateComponent animated:YES];
    
    if (type == 3) {
        NSInteger indexYear = [year indexOfObject:listItems[2]];
        [picker selectRow:indexYear inComponent:kYearComponent animated:YES];;
    }

    picker.showsSelectionIndicator = YES;
    super.picker = picker;
    [super addActionSheet:view withCell:c];
}

- (void) dateSelected:(id)sender {
    
    //find the current selected cell row in the table view
    //NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    //UITableViewCell *cellSelect = [self.tableView cellForRowAtIndexPath:indexPath];
    //set the cell value from the date picker value and format it properly
    NSInteger monthRow = [picker selectedRowInComponent:kMonthComponent];
    NSInteger dateRow = [picker selectedRowInComponent:kDateComponent];
    NSString *day = dateOfMonth[dateRow];
    NSString *mon = months[monthRow][0];
    NSString *temp = [NSString stringWithFormat:@"%@ %@",mon, day];
    string = temp;
    
    if(type == 3){
        NSInteger yearRow = [picker selectedRowInComponent:kYearComponent];
        NSString *tempYear = year[yearRow];
        string = [NSString stringWithFormat:@"%@ %@",temp,tempYear];
    }
    
    [super dateSelected:sender];
    //remove the date picker view form the super view
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
