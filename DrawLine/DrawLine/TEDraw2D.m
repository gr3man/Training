//
//  TEDraw2D.m
//  DrawLine
//
//  Created by Tuấn Nguyễn Anh on 5/21/13.
//  Copyright (c) 2013 Tuấn Nguyễn Anh. All rights reserved.
//

#import "TEDraw2D.h"

@implementation TEDraw2D

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 2.0);
    CGFloat dashArray[] = {6,4,2,2,2,4};
    //Đặt line là đường nét đứt, tham số đầu là context, thứ hai là điểm bắt đầu vẽ trong mảng
    //thứ 3 là 1 mảng các số chỉ ra lần lượt là: khoảng cách của đoạn tô, khoảng cách đoạn không tô, khoảng cách đoạn tô, ..., đến hết.
    //Thứ 4 là số đoạn trong mảng áp dụng.
    //Ví dụ truyền vào như ở dưới thì đường dash sẽ có đoạn tô rộng 2, đoạn không tô rộng 4 rồi đoạn tô rộng 6 rồi đoạn không tô rộng 8. Đường này sẽ bắt đầu với đoạn thứ 3 (tức là đoạn không tô rộng 6). Đường này áp dụng cả 4 đoạn này để vẽ.
    
    CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
    CGContextMoveToPoint(context, 5, 5);
    CGContextAddLineToPoint(context, 5, 300);
    CGContextStrokePath(context);
    
    CGContextSetLineDash(context, 6, dashArray, 4);
    
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
    CGContextMoveToPoint(context, 5, 10);
    CGContextAddLineToPoint(context, self.bounds.size.width - 5, 10);
    CGContextStrokePath(context);
    
    CGContextSetStrokeColorWithColor(context, [UIColor yellowColor].CGColor);
    CGContextMoveToPoint(context, 5, 20);
    CGContextAddLineToPoint(context, self.bounds.size.width - 5, 20);
    CGContextStrokePath(context);

    CGContextSetStrokeColorWithColor(context, [UIColor blueColor].CGColor);
    CGContextMoveToPoint(context, 5, 30);
    CGContextAddLineToPoint(context, self.bounds.size.width - 5, 30);
    CGContextStrokePath(context);
    
    //Reset lại solid line
    CGContextSetLineDash(context, 0, NULL, 0);
    CGContextSetStrokeColorWithColor(context, [UIColor purpleColor].CGColor);
    CGRect rec = CGRectMake(100, 80, 150, 90);
    CGContextAddRect(context, rec);
    CGContextStrokePath(context);
    
    CGContextSetStrokeColorWithColor(context, [UIColor blueColor].CGColor);
    //CGRect recFrame = CGRectMake(80, 220, 150, 150);
    
    //CGContextAddEllipseInRect(context, recFrame);
    
    CGPoint center = CGPointMake(self.frame.size.width / 2, 300);
    CGPoint inRound;
    int tempHeight;
    int tempWidth;
    float red;
    float green;
    float blue;
    CGFloat radi = 120;
    //Vẽ đường tròn
    CGContextAddArc(context, center.x, center.y, radi, 0, 2*M_PI, 1);
    CGContextStrokePath(context);
    
    CGContextSetLineDash(context, 0, NULL, 0);
    CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
    CGContextMoveToPoint(context, center.x - 10, center.y - 10);
    CGContextAddLineToPoint(context, center.x + 10, center.y + 10);
    CGContextStrokePath(context);
    CGContextMoveToPoint(context, center.x + 10, center.y - 10);
    CGContextAddLineToPoint(context, center.x - 10, center.y + 10);
    CGContextStrokePath(context);
    
    CGContextMoveToPoint(context, center.x, center.y);
    for (int k = 0; k < 4; k++) {
        CGContextSetLineDash(context, 0, dashArray, k+3);
        red = arc4random() % (256);
        green = arc4random() % (256);
        blue = arc4random() % (256);
        CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:1].CGColor);
        tempHeight = cos(M_PI_4 * (2*k))*radi;
        tempWidth = sin(M_PI_4 * (2*k))*radi;
        inRound = CGPointMake(center.x + tempWidth, center.y - tempHeight);
        CGContextAddLineToPoint (context, inRound.x, inRound.y);
        CGContextStrokePath(context);
        CGContextMoveToPoint(context, center.x, center.y);
    }
    
    CGContextSetLineDash(context, 0, NULL, 0);
    CGContextSetStrokeColorWithColor(context,[UIColor redColor].CGColor);
//    CGContextMoveToPoint(context, 10, 10);
//    CGContextAddCurveToPoint(context, 300, 50, 100, 400, 300, 200);
//    CGContextStrokePath(context);
    
//    CGContextMoveToPoint(context, 10, 200);
//    CGContextAddQuadCurveToPoint(context, 150, 50, 300, 200);
//    CGContextStrokePath(context);

}


@end
