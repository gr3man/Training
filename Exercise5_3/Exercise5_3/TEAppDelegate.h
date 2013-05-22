//
//  TEAppDelegate.h
//  Exercise5_3
//
//  Created by Tuấn Nguyễn Anh on 5/2/13.
//  Copyright (c) 2013 Tuấn Nguyễn Anh. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kDateComponent 0
#define kMonthComponent 1

@class TEViewController;

@interface TEAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) TEViewController *viewController;

@end
