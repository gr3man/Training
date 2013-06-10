//
// TECustomSlider.h
// Exercise7_3
//
// Created by Tuấn Nguyễn Anh on 6/3/13.
// Copyright (c) 2013 Tuấn Nguyễn Anh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TEPopupView.h"
#import "TECustomRoundRectButton.h"

typedef enum {
    sldDate,
    sldTime
} TypeSlider;

@protocol TECustomSliderDelegate <NSObject>

- (void) selectedTime : (NSString *) time;

@end

@interface TECustomSlider : UISlider <TEPopupMenuDelegate>

{
    TypeSlider type;
    TECustomRoundRectButton *button;
    NSDate *date;
    NSInteger min;
    NSInteger hour;
    NSInteger sec;
    NSInteger day;
    NSInteger month;
    NSInteger year;
    float previousValue;
    id<TECustomSliderDelegate> delegate;
}

@property (assign, nonatomic) NSInteger ratioZoom;
@property (retain, nonatomic) TEPopupView *popupMenu;
@property (retain, nonatomic) UIButton *button;
@property (retain) id<TECustomSliderDelegate> delegate;

- (void)setType:(TypeSlider)newType;
- (void)setDate:(NSDate *)newDate;
- (NSDate *)date;
- (void)initButtonContainTime;
- (void)initValueOfSlider;
- (float)getValueFromTime;
- (void)getDateFromInt:(int)value;
- (void)getDateComponent:(NSDate *)dateValue;
- (bool)isLeapYear;
- (NSString *)generateStringOfTime;
- (IBAction)valueChanged:(UISlider *)sender;
- (void) showPopup;

@end