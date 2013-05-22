//
//  TECustomPicker.m
//  Exercise5_3
//
//  Created by Tuấn Nguyễn Anh on 5/7/13.
//  Copyright (c) 2013 Tuấn Nguyễn Anh. All rights reserved.
//

#import "TECustomPicker.h"

@implementation TECustomPicker

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    
//    months = @[@[@"January",@"31"],@[@"February",@"28"],@[@"March",@"31"],@[@"April",@"30"],@[@"May",@"31"],@[@"June",@"30"],@[@"July",@"31"],@[@"August",@"31"],@[@"September",@"30"],@[@"October",@"31"],@[@"November",@"30"],@[@"December",@"31"]];
//    dateOfMonth = [[NSMutableArray alloc] init];
//    for(int i = 1; i<=31; i++){
//        [dateOfMonth addObject:[NSString stringWithFormat:@"%d",i]];
//    }

    
    self.menu = [[UIActionSheet alloc] initWithTitle:nil
                                            delegate:self
                                   cancelButtonTitle:nil
                              destructiveButtonTitle:nil
                                   otherButtonTitles:nil];
    self.doneButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.doneButton setFrame:CGRectMake(self.frame.size.width - 59 - 10, 13, 59, 34)];
    [self.doneButton setTitle:@"Done" forState:UIControlStateNormal];
    [self.doneButton  addTarget:self action:@selector(dateSelected:) forControlEvents:UIControlEventTouchUpInside];
    self.showsSelectionIndicator = YES;
    
    //NSArray *listItems = [targetCell.detailTextLabel.text componentsSeparatedByString:@" "];
    
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

- (void) dateSelected:(id)sender {
    
    //find the current selected cell row in the table view
    //NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    //UITableViewCell *cellSelect = [self.tableView cellForRowAtIndexPath:indexPath];
    //set the cell value from the date picker value and format it properly
    NSInteger monthRow = [self selectedRowInComponent:kMonthComponent];
    NSInteger dateRow = [self selectedRowInComponent:kDateComponent];
    
    NSString *day = dateOfMonth[dateRow];
    NSString *mon = months[monthRow][0];
    NSString *returnString = [NSString stringWithFormat:@"%@ %@",mon, day];
    if(type == 3){
        NSInteger yearRow = [self selectedRowInComponent:kYearComponent];
        NSString *tempYear = year[yearRow];
        returnString = [NSString stringWithFormat:@"%@ %@",returnString,tempYear];
    }
    cell.detailTextLabel.text =  returnString;
    [self.menu dismissWithClickedButtonIndex:0 animated:YES];
    //remove the date picker view form the super view
}

- (void)addActionSheet:(UIView *)view withCell:(UITableViewCell *)c{
    cell = c;
    CGSize pickerSize = [self sizeThatFits:CGSizeZero];
    CGRect pickerRect = self.frame;
    
    [self reloadComponent:kDateComponent];
    
    NSInteger indexMonth = 0;
    NSArray *listItems = [c.detailTextLabel.text componentsSeparatedByString:@" "];
    for (int i = 0; i < [months count]; i++) {
        if([months[i][0] isEqualToString:listItems[0]]){
            indexMonth = i;
            break;
        }
    }
    NSInteger indexDate = [listItems[1] integerValue];
    [self selectRow:indexMonth inComponent:kMonthComponent animated:YES];
    [self selectRow:indexDate - 1 inComponent:kDateComponent animated:YES];
    
    if (type == 3) {
        NSInteger indexYear = [year indexOfObject:listItems[2]];
        [self selectRow:indexYear inComponent:kYearComponent animated:YES];;
    }
    
    [self selectRow:indexMonth inComponent:kMonthComponent animated:YES];
    [self selectRow:indexDate - 1 inComponent:kDateComponent animated:YES];
    
    [self.menu addSubview:self.doneButton];
    [self.menu addSubview:self];
    [self.menu showInView:view];
    CGRect menuRect = self.menu.frame;
    CGFloat orgHeight = menuRect.size.height + self.doneButton.frame.size.height;
    menuRect.origin.y -= pickerSize.height + self.doneButton.frame.size.height;
    menuRect.size.height = orgHeight+pickerRect.size.height;
    
    self.menu.frame = menuRect;
    pickerRect.origin.y = orgHeight;
    self.frame = pickerRect;
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
