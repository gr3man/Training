//
//  TEViewController.h
//  Exercise7_2
//
//  Created by Tuấn Nguyễn Anh on 4/26/13.
//  Copyright (c) 2013 Tuấn Nguyễn Anh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TECustomSlider.h"


@interface TEViewController : UIViewController
- (IBAction)btnClicked:(UIButton *)sender;
@property (strong, nonatomic) IBOutlet TECustomSlider *customSliderDate;
@property (strong, nonatomic) IBOutlet TECustomSlider *customSliderTime;

@end

