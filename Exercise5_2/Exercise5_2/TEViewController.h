//
//  TEViewController.h
//  Exercise5_2
//
//  Created by Tuan Nguyen Anh on 4/16/13.
//  Copyright (c) 2013 Tuan Nguyen Anh. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kDateComponent 0
#define kMonthComponent 1

@interface TEViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate,UIPickerViewDataSource,UIPickerViewDelegate>

@property (strong, nonatomic) IBOutlet UIButton *doneButton;

@property (copy, nonatomic) NSArray *rowFields;
@property (copy, nonatomic) NSArray *selectionFields;

@property (strong, nonatomic) NSMutableArray *dateOfMonth;
@property (strong, nonatomic) NSArray *month;

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSDateFormatter *dateFormat;
@property (nonatomic, strong) NSDateFormatter *timeFormat;
@property (nonatomic, strong) UIPickerView *picker;
@property (nonatomic, strong) UIActionSheet *menu;

@end
