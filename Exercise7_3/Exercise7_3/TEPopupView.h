//
//  TEPopupView.h
//  Exercise7_3
//
//  Created by Tuấn Nguyễn Anh on 6/3/13.
//  Copyright (c) 2013 Tuấn Nguyễn Anh. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PopupMenuDelegate <NSObject>

- (void) miniSliderChange : (float) value;

@end

@interface TEPopupView : UIView
{
    float currentValue;
    float afterValue;
    id<PopupMenuDelegate> delegate;
    UISlider *miniSlider;
    BOOL invi;
}
@property (assign) float currentValue;
@property (assign) float afterValue;
@property (assign) BOOL invi;
@property (readwrite, nonatomic) UISlider *miniSlider;
@property (retain) id<PopupMenuDelegate> delegate;
- (IBAction)valueChanged:(UISlider *)sender;
- (void) addSlider;
- (void) resetValue;

@end
