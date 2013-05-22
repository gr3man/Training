//
//  TEViewController.h
//  Exercise5_3
//
//  Created by Tuấn Nguyễn Anh on 5/2/13.
//  Copyright (c) 2013 Tuấn Nguyễn Anh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TEPickerData.h"
#import "TECustomPicker.h"

@interface TEViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIPickerViewDelegate,UIPickerViewDataSource>
{
    NSArray *rowFields;
    NSArray *selectionFields;
    TEPickerData *data;
}
@property (strong, nonatomic) IBOutlet UITableView *table;
@property (nonatomic, strong) TECustomPicker *picker;

@end
