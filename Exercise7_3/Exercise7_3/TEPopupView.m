//
// TEPopupView.m
// Exercise7_3
//
// Created by Tuấn Nguyễn Anh on 6/3/13.
// Copyright (c) 2013 Tuấn Nguyễn Anh. All rights reserved.
//

#import "TEPopupView.h"
#import "TECustomSlider.h"

@implementation TEPopupView
@synthesize miniSlider, delegate, originalValue, midValue, viewForPopup, frameOfTriangular, strokeWidth, cornerRadius, spaceToMinislider;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        originalValue = 0;
        miniSlider = [[UISlider alloc] initWithFrame: CGRectMake(spaceToMinislider, 6.5, self.frame.size.width - spaceToMinislider*2, 23)];
        //[self setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background_maptools_view.png"]]];
        [self setBackgroundColor:[UIColor clearColor]];
        strokeWidth = 0;
        cornerRadius = 6;
        frameOfTriangular = CGRectMake(0, self.frame.size.height, 15, 5);
        [miniSlider addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
    }
    return self;
}

- (void)addSlider
{
    miniSlider.value = (miniSlider.maximumValue -  miniSlider.minimumValue)/2;
    [self addSubview:miniSlider];
}

- (IBAction)valueChanged:(UISlider *)sender
{
    [delegate miniSliderChange:sender.value];
}

- (void)setFrameforTriangular:(float)coorX
{
    frameOfTriangular = CGRectMake(coorX, 0, 15, 5);
    //Vẽ lại UIView
    [self setNeedsDisplay];
}

- (void)showPopup
{
    //[view addSubview:self];
    UIWindow *keyWindow = [[[UIApplication sharedApplication] delegate] window];
    viewForPopup = [[TEInterView alloc] initWithFrame:CGRectMake(keyWindow.frame.origin.x, keyWindow.frame.origin.y, keyWindow.frame.size.width, keyWindow.frame.size.height)];
    [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y + [UIApplication sharedApplication].statusBarFrame.size.height, self.frame.size.width, self.frame.size.height + frameOfTriangular.size.height)];
    //Add 1 UIView lên trên window
    [keyWindow addSubview:viewForPopup];
    [viewForPopup addSubview:self];
    //Giá trị của slider phụ ở là ở giữa
    miniSlider.value = (miniSlider.maximumValue - miniSlider.minimumValue)/2;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.4];
    [self setAlpha:1.0];
    [UIView commitAnimations];
}

//+ (void) hidePopup:(UIView *)view
//{
//    for (UIView* subView in view.subviews)
//    {
//        if([subView isKindOfClass:[TEPopupView class]]){
//            [subView removeFromSuperview];
//        } else if (!subView.userInteractionEnabled){
//            [subView setUserInteractionEnabled:YES];
//        }
//        
//    }
//}


 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
     CGContextRef context = UIGraphicsGetCurrentContext();
     CGContextSetLineWidth(context, strokeWidth);
     CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
     CGContextSetFillColorWithColor(context, [UIColor grayColor].CGColor);
     CGFloat minx = CGRectGetMinX(rect) + strokeWidth;
     CGFloat midx = CGRectGetMidX(rect);
     CGFloat maxx = CGRectGetMaxX(rect) - strokeWidth;
     CGFloat miny = CGRectGetMinY(rect) + strokeWidth + frameOfTriangular.size.height;
     CGFloat midy = CGRectGetMidY(rect) + frameOfTriangular.size.height/2;
     CGFloat maxy = CGRectGetMaxY(rect) - strokeWidth - frameOfTriangular.size.height;
     
     CGContextMoveToPoint(context, minx, midy);
     CGContextAddArcToPoint(context, minx, miny, midx, miny, cornerRadius);
     
     CGContextAddLineToPoint(context, frameOfTriangular.origin.x, miny);
     CGContextAddLineToPoint(context, frameOfTriangular.origin.x + frameOfTriangular.size.width/2, miny - frameOfTriangular.size.height);
     CGContextAddLineToPoint(context, frameOfTriangular.origin.x + frameOfTriangular.size.width, miny);
     
     CGContextAddArcToPoint(context, maxx, miny, maxx, midy, cornerRadius);
     CGContextAddArcToPoint(context, maxx, maxy, frameOfTriangular.origin.x + frameOfTriangular.size.width, maxy, cornerRadius);
     //Vẽ tam giác
//     CGContextAddLineToPoint(context, frameOfTriangular.origin.x + frameOfTriangular.size.width, maxy);
//     CGContextAddLineToPoint(context, frameOfTriangular.origin.x + frameOfTriangular.size.width/2, frameOfTriangular.size.height + maxy);
//     CGContextAddLineToPoint(context, frameOfTriangular.origin.x, maxy);
     
     CGContextAddArcToPoint(context, minx, maxy, minx, midy, cornerRadius);
     
     CGContextClosePath(context);
     CGContextDrawPath(context, kCGPathFillStroke);
 }


@end