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
@property (strong, nonatomic) IBOutlet TECustomSlider *customSliderDate;
@property (strong, nonatomic) IBOutlet TECustomSlider *customSliderTime;
- (IBAction)btnClicked:(UIButton *)sender;

@end