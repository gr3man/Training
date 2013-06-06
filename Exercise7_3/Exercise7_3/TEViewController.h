//
//  TEViewController.h
//  Exercise7_3
//
//  Created by Tuấn Nguyễn Anh on 6/3/13.
//  Copyright (c) 2013 Tuấn Nguyễn Anh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TECustomSlider.h"


@interface TEViewController : UIViewController
@property (strong, nonatomic) IBOutlet TECustomSlider *asf;
@property (strong, nonatomic) TECustomSlider *customSliderDate;
@property (strong, nonatomic) TECustomSlider *customSliderTime;
@property (strong, nonatomic) UIView *layoutView;
- (IBAction)btnClicked:(UIButton *)sender;

@end