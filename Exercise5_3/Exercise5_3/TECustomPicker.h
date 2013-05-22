//
//  TECustomPicker.h
//  Exercise5_3
//
//  Created by Tuấn Nguyễn Anh on 5/7/13.
//  Copyright (c) 2013 Tuấn Nguyễn Anh. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kDateComponent 0
#define kMonthComponent 1
#define kYearComponent 2

@interface TECustomPicker : UIPickerView<UIActionSheetDelegate>
{
    UITableViewCell *cell;
    NSMutableArray *dateOfMonth;
    NSMutableArray *months;
    NSMutableArray *year;
    int type;
}

@property (nonatomic, strong) UIActionSheet *menu;
@property (nonatomic, strong) UIButton *doneButton;

- (void) dateSelected:(id)sender;
- (void) addActionSheet : (UIView *)view withCell: (UITableViewCell*)c;
- (void) setMonths : (NSArray *)mon;
- (void) setDateOfMonth : (NSMutableArray *)day;
- (void) setYear : (NSMutableArray *)newYear;
- (void) setType : (int)t;
- (int) type;

@end
