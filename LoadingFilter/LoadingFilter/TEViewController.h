//
//  TEViewController.h
//  LoadingFilter
//
//  Created by Tuấn Nguyễn Anh on 6/27/13.
//  Copyright (c) 2013 Tuấn Nguyễn Anh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TEScrollFilterPicker.h"

@interface TEViewController : UIViewController <ScrollForFliterDelegate>
{
    UIImageView *viewShowImage;
    UIActivityIndicatorView *actiIndicator;
}

@property (retain, nonatomic) UIImageView *viewShowImage;

@end
