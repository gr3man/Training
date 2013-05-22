//
//  TEViewController.h
//  Exercise6
//
//  Created by Tuan Nguyen Anh on 4/17/13.
//  Copyright (c) 2013 Tuan Nguyen Anh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TEViewController : UIViewController
@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentBar2;
@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentBar;
@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentBorder;
@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentPlain;

- (IBAction)segmentClicked :(UISegmentedControl *)sender;

@end
