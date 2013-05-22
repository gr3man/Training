//
//  TEViewController.h
//  Exercise7
//
//  Created by Tuan Nguyen Anh on 4/23/13.
//  Copyright (c) 2013 Tuan Nguyen Anh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TEViewController : UIViewController
@property (strong, nonatomic) IBOutlet UISlider *sliderDate;
@property (strong, nonatomic) IBOutlet UISlider *sliderTime;
@property (strong, nonatomic) IBOutlet UILabel *labelTime;
@property (strong, nonatomic) IBOutlet UILabel *labelDate;

- (IBAction)timeChanged:(UISlider *)sender;
- (IBAction)dateChanged:(UISlider *)sender;
@end
