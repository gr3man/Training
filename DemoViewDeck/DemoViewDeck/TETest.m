//
//  TETest.m
//  DemoViewDeck
//
//  Created by Tuấn Nguyễn Anh on 7/3/13.
//  Copyright (c) 2013 Tuấn Nguyễn Anh. All rights reserved.
//

#import "TETest.h"
#import "IIViewDeckController.h"

@implementation TETest
@synthesize delegateTest;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        //UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        //[btn setTitle:@"Test" forState:UIControlStateNormal];
    }
    return self;
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [delegateTest touchInView];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
