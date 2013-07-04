//
//  TETest.h
//  DemoViewDeck
//
//  Created by Tuấn Nguyễn Anh on 7/3/13.
//  Copyright (c) 2013 Tuấn Nguyễn Anh. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TestViewDelegate <NSObject>

- (void) touchInView;

@end

@interface TETest : UITableView
{
    id<TestViewDelegate> delegate;
}

@property (weak, nonatomic) id<TestViewDelegate> delegateTest;

@end
