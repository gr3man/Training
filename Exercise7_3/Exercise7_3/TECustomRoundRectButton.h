//
//  TECustomRoundRectButton.h
//  Exercise7_3
//
//  Created by Tuấn Nguyễn Anh on 6/6/13.
//  Copyright (c) 2013 Tuấn Nguyễn Anh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TECustomRoundRectButton : UIButton
{
    CGFloat cornerRadius;
    CGFloat strokeWidth;
    UIFont *defaultFont;
    UIColor *rectColor;
}
@property CGFloat cornerRadius;
@property CGFloat strokeWidth;
@property (retain, nonatomic) UIFont *defaultFont;
@property (nonatomic, retain) UIColor *rectColor;

- (void) setDefaultFont:(UIFont *)newFont;

@end
