//
// TEPopupView.m
// Exercise7_3
//
// Created by Tuấn Nguyễn Anh on 6/3/13.
// Copyright (c) 2013 Tuấn Nguyễn Anh. All rights reserved.
//

#import "TEPopupView.h"

@implementation TEPopupView
@synthesize miniSlider, delegate, originalValue, midValue;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.layer.cornerRadius = 5;
        self.layer.borderWidth = 0;
        originalValue = 0;
        
        miniSlider = [[UISlider alloc] initWithFrame: CGRectMake(5, 4, self.frame.size.width - 10, 23)];
        [self setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background_maptools_view.png"]]];
        [miniSlider addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
        triangular = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"btn-arrow-down.png"]];
        [self addSubview:triangular];
    }
    return self;
}

- (void) addSlider
{
    miniSlider.value = (miniSlider.maximumValue -  miniSlider.minimumValue)/2;
    [self addSubview:miniSlider];
}

- (IBAction)valueChanged:(UISlider *)sender
{
    [delegate miniSliderChange:sender.value];
}

- (void) setFrameforTriangular:(float)coorX
{
    [triangular setFrame:CGRectMake(coorX, self.frame.size.height, triangular.frame.size.width, triangular.frame.size.height)];
}

- (void) showPopup : (UIView *) view
{
    //Disable tất cả các view trừ popup
    for (UIView* subView in view.subviews)
    {
        [subView setUserInteractionEnabled:NO];
    }
    [self setUserInteractionEnabled:YES];
    //[self setUserInteractionEnabled:YES];
    
    //[view addSubview:self];
    UIWindow *keyWindow = [[[UIApplication sharedApplication] delegate] window];
    [keyWindow addSubview:self];
    miniSlider.value = (miniSlider.maximumValue - miniSlider.minimumValue)/2;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.4];
    [self setAlpha:1.0];
    [UIView commitAnimations];
}

+ (void) hidePopup:(UIView *)view
{
    for (UIView* subView in view.subviews)
    {
        if([subView isKindOfClass:[TEPopupView class]]){
            [subView removeFromSuperview];
        } else if (!subView.userInteractionEnabled){
            [subView setUserInteractionEnabled:YES];
        }
        
    }
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