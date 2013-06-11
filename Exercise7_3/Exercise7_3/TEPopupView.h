//
// TEPopupView.h
// Exercise7_3
//
// Created by Tuấn Nguyễn Anh on 6/3/13.
// Copyright (c) 2013 Tuấn Nguyễn Anh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "TEInterView.h"

@protocol TEPopupMenuDelegate <NSObject>

- (void) miniSliderChange : (float) value;

@end

@interface TEPopupView : UIView
{
    float originalValue;
    float midValue;
    id<TEPopupMenuDelegate> delegate;
    UISlider *miniSlider;
    TEInterView *viewForPopup;
    CGRect frameOfTriangular;
    CGFloat strokeWidth;
    CGFloat cornerRadius;
    float spaceToMinislider;
}
@property (assign) float originalValue;
@property (assign) float midValue;
@property (readwrite, nonatomic) UISlider *miniSlider;
@property (retain, nonatomic) TEInterView *viewForPopup;
@property (assign) CGRect frameOfTriangular;
@property CGFloat strokeWidth;
@property CGFloat cornerRadius;
@property float spaceToMinislider;
@property (retain) id<TEPopupMenuDelegate> delegate;

- (IBAction)valueChanged:(UISlider *)sender;
- (void)addSlider;
- (void)setFrameforTriangular:(float)coorX;
- (void)showPopup;
//+ (void) hidePopup:(UIView *)view;

@end