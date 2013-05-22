//
//  TECustomView.m
//  FunnyText
//
//  Created by Tuấn Nguyễn Anh on 5/14/13.
//  Copyright (c) 2013 Tuấn Nguyễn Anh. All rights reserved.
//

#import "TECustomView.h"
#import <CoreText/CoreText.h>

@implementation TECustomView

@synthesize attString;

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
    [super drawRect:rect];
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CGContextTranslateCTM(context, 0, self.bounds.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    CTLineRef line = CTLineCreateWithAttributedString((CFAttributedStringRef)attString);
    
    CGContextSetTextPosition(context, 0, self.bounds.size.height - 50);
    CTLineDraw(line, context);
    CFRelease(line);
}


@end
