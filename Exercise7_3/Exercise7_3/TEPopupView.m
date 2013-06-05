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
        [self setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background_maptools_view.png"]]];
        [miniSlider addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
        triangular = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"btn-arrow-down.png"]];
        [self addSubview:triangular];
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

- (void) setFrameforTriangular:(float)coorX
{
    [triangular setFrame:CGRectMake(coorX, self.frame.size.height, triangular.frame.size.width, triangular.frame.size.height)];
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
