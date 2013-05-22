//
//  TEViewController.h
//  Exercise5
//
//  Created by Tuan Nguyen Anh on 4/15/13.
//  Copyright (c) 2013 Tuan Nguyen Anh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TEViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate>
@property (strong, nonatomic) IBOutlet UIButton *doneButton;

@property (copy, nonatomic) NSArray *rowFields;
@property (copy, nonatomic) NSArray *selectionFields;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSDateFormatter *dateFormat;
@property (nonatomic, strong) NSDateFormatter *timeFormat;
@property (nonatomic, strong) UIDatePicker *myDatePicker;
@property (nonatomic, strong) UIActionSheet *menu;

@end
