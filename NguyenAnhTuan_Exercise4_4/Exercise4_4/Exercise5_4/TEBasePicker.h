//
//  TEBasePicker.h
//  Exercise5_4
//
//  Created by Tuấn Nguyễn Anh on 5/15/13.
//  Copyright (c) 2013 Tuấn Nguyễn Anh. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BasePickerDelegate <NSObject>

- (void) setCellString : (NSString *) stringSet;

@end

@interface TEBasePicker : UIView  <UIActionSheetDelegate>
{
    UITableViewCell *cell;
    NSString *string;
    id <BasePickerDelegate> delegate;
}

@property (nonatomic, strong) UIActionSheet *menu;
@property (nonatomic, strong) UIButton *doneButton;
@property (nonatomic, strong) UIPickerView *picker;
@property (retain) id<BasePickerDelegate> delegate;

- (void) addActionSheet:(UIView *) view withCell: (UITableViewCell*)c;
- (IBAction) dateSelected:(id)sender;

@end
