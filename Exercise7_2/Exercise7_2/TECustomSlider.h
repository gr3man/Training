//
//  TECustomSlider.h
//  Exercise7_2
//
//  Created by Tuan Nguyen Anh on 4/27/13.
//  Copyright (c) 2013 Tuấn Nguyễn Anh. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
	sldDate,
    sldTime
} TypeSlider;

@interface TECustomSlider : UISlider

{
    TypeSlider type;
    UILabel *label;
    NSDate *date;
    NSInteger min;
    NSInteger hour;
    NSInteger sec;
    NSInteger day;
    NSInteger month;
    NSInteger year;
    float previousValue;
}

//- (id)initWithSlider:(UISlider *) newSlider;
//- (void)setSlider : (UISlider *)newSlider;
//- (UISlider *)slider;
- (void)setType : (TypeSlider)newType;
- (TypeSlider) Type;
- (void)setDate : (NSDate *)newDate;
- (NSDate *) Date;
- (void) initUIlable;
- (void) initValue;
- (float)getValueFromTime;
- (void)getDateFromInt : (int) value;
- (void)getDateComponent : (NSDate *)dateValue;
- (bool)isLeapYear;
- (NSString *) stringForLabel;
- (IBAction)valueChanged:(UISlider *)sender;

@end
