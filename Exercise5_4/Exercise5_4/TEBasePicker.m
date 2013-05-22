//
//  TEBasePicker.m
//  Exercise5_4
//
//  Created by Tuấn Nguyễn Anh on 5/15/13.
//  Copyright (c) 2013 Tuấn Nguyễn Anh. All rights reserved.
//

#import "TEBasePicker.h"

@implementation TEBasePicker
@synthesize doneButton;
@synthesize menu;
@synthesize picker;
@synthesize delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        picker.showsSelectionIndicator = YES;
        menu = [[UIActionSheet alloc] initWithTitle:nil
                                                delegate:self
                                       cancelButtonTitle:nil
                                  destructiveButtonTitle:nil
                                       otherButtonTitles:nil];
        
        doneButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [doneButton setTitle:@"Done" forState:UIControlStateNormal];
        [doneButton  addTarget:self action:@selector(dateSelected:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void) addActionSheet:(UIView *)view withCell:(UITableViewCell *)c{
    
    //[picker selectRow:indexMonth inComponent:kMonthComponent animated:YES];
    //[picker selectRow:indexDate-1 inComponent:kDateComponent animated:YES];
    
    cell = c;
    CGSize pickerSize = [picker sizeThatFits:CGSizeZero];
    CGRect pickerRect = picker.frame;
    //self.test = [[UIPickerView alloc] init];
    //Thêm vào actionsheet nút done và picker view
    [doneButton setFrame:CGRectMake(picker.frame.size.width - 59 - 10, 13, 59, 34)];
    [menu addSubview:doneButton];
    [menu addSubview:picker];
    //Show actionsheet lên view
    [menu showInView:view];
    CGRect menuRect = menu.frame;
    //Chiều cao = chiều cao actionsheet + button
    CGFloat orgHeight = menuRect.size.height + doneButton.frame.size.height;
    //Tọa độ và chiều cao actionsheet được tính lại để hiển thị được picker và button
    menuRect.origin.y -= pickerSize.height + doneButton.frame.size.height;
    menuRect.size.height = orgHeight+pickerRect.size.height;
    
    menu.frame = menuRect;
    pickerRect.origin.y = orgHeight;
    picker.frame = pickerRect;
}

- (IBAction)dateSelected:(id)sender
{
    bool check = [picker isKindOfClass:[UIDatePicker class]];
    if(check){
        UIDatePicker *temp = (UIDatePicker *) picker;
        NSDateFormatter *timeFormat = [[NSDateFormatter alloc] init];
        [timeFormat setDateStyle:NSDateFormatterNoStyle];
        [timeFormat setTimeStyle:NSDateFormatterMediumStyle];
        string = [timeFormat stringFromDate:temp.date];
    }
    [delegate setCellString:string];
    //cell.detailTextLabel.text = string;
    [menu dismissWithClickedButtonIndex:0 animated:YES];
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
