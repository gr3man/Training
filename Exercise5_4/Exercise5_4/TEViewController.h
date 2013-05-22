//
//  TEViewController.h
//  Exercise5_4
//
//  Created by Tuấn Nguyễn Anh on 5/15/13.
//  Copyright (c) 2013 Tuấn Nguyễn Anh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TEBasePicker.h"
#import "TECustomPicker.h"
#import "TEPickerData.h"

@interface TEViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate,UIPickerViewDataSource,UIPickerViewDelegate,BasePickerDelegate>
{
    NSDateComponents *timeComp;
    UIDatePicker *timePicker;
    UIPickerView *datePicker;
    TEPickerData *data;
    int selectedMonth;
}

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (copy, nonatomic) NSArray *rowFields;
@property (copy, nonatomic) NSArray *selectionFields;
@property (nonatomic, strong) NSDateFormatter *timeFormat;
@property (nonatomic, strong) TEBasePicker *myTimePicker;
@property (nonatomic, strong) TECustomPicker *myDatePicker;

@end
