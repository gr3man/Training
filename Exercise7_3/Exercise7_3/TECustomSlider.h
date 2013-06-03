//
//  TECustomSlider.h
//  Exercise7_3
//
//  Created by Tuấn Nguyễn Anh on 6/3/13.
//  Copyright (c) 2013 Tuấn Nguyễn Anh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TEPopupView.h"

typedef enum {
	sldDate,
    sldTime
} TypeSlider;

@interface TECustomSlider : UISlider <PopupMenuDelegate>

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
    CGRect popupFrame;
    int iden;
}

//- (id)initWithSlider:(UISlider *) newSlider;
//- (void)setSlider : (UISlider *)newSlider;
//- (UISlider *)slider;

@property (assign, nonatomic) NSInteger ratioZoom;
@property (retain, nonatomic) TEPopupView *popupMenu;
@property (assign, nonatomic) int iden;

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
- (void) changeLocation:(UIInterfaceOrientation)orient;
- (void) showPopup;


@end
