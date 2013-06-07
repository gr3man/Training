//
// TEPopupView.h
// Exercise7_3
//
// Created by Tuấn Nguyễn Anh on 6/3/13.
// Copyright (c) 2013 Tuấn Nguyễn Anh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@protocol PopupMenuDelegate <NSObject>

- (void) miniSliderChange : (float) value;

@end

@interface TEPopupView : UIView
{
    float originalValue;
    float midValue;
    id<PopupMenuDelegate> delegate;
    UISlider *miniSlider;
    UIImageView *triangular;
}
@property (assign) float originalValue;
@property (assign) float midValue;
@property (readwrite, nonatomic) UISlider *miniSlider;
@property (retain) id<PopupMenuDelegate> delegate;
- (IBAction)valueChanged:(UISlider *)sender;
- (void) addSlider;
- (void) setFrameforTriangular : (float) coorX;
- (void) showPopup : (UIView *) view;
+ (void) hidePopup:(UIView *)view;

@end