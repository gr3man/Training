//
//  TEPopupView.m
//  Exercise7_3
//
//  Created by Tuấn Nguyễn Anh on 6/3/13.
//  Copyright (c) 2013 Tuấn Nguyễn Anh. All rights reserved.
//

#import "TEPopupView.h"

@implementation TEPopupView
@synthesize miniSlider, delegate, currentValue, afterValue, invi;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        miniSlider = [[UISlider alloc] initWithFrame: CGRectMake(5, 4, self.frame.size.width - 10, 23)];
        [miniSlider addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
    }
    invi = YES;
    return self;
}

- (void) addSlider
{
    miniSlider.value = miniSlider.maximumValue/2;
    [self addSubview:miniSlider];
}

- (void) resetValue
{
    miniSlider.value = miniSlider.maximumValue/2;
    currentValue = miniSlider.value;
    afterValue = miniSlider.value;
}

- (IBAction)valueChanged:(UISlider *)sender
{
    [delegate miniSliderChange:sender.value];
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
