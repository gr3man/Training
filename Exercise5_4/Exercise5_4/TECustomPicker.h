//
//  TECustomPicker.h
//  Exercise5_4
//
//  Created by Tuan Nguyen Anh on 5/19/13.
//  Copyright (c) 2013 Tuấn Nguyễn Anh. All rights reserved.
//

#import "TEBasePicker.h"

#define kDateComponent 0
#define kMonthComponent 1
#define kYearComponent 2

@interface TECustomPicker : TEBasePicker
{
    NSMutableArray *dateOfMonth;
    NSMutableArray *months;
    NSMutableArray *year;
    int type;
    int selectedMonth;
}

- (void) setMonths : (NSArray *)mon;
- (void) setDateOfMonth : (NSMutableArray *)day;
- (void) setYear : (NSMutableArray *)newYear;
- (void) setType : (int)t;
- (int) type;
- (int) selectedMonth;
- (void) setSelectedMonth : (int) selMon;

@end
