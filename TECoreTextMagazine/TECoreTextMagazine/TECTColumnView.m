//
//  TECTColumnView.m
//  TECoreTextMagazine
//
//  Created by Tuấn Nguyễn Anh on 5/13/13.
//  Copyright (c) 2013 Tuấn Nguyễn Anh. All rights reserved.
//

#import "TECTColumnView.h"
#import <CoreText/CoreText.h>

//This class render for frame.
//Each of text column we create a instace of it.
@implementation TECTColumnView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void) setCTFrame:(id)f{
    ctFrame = f;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    //Core Text gốc tọa độ ở góc dưới bên trái, trục x tăng từ trái sang phải, y tăng từ dưới lên trên, nên khi vẽ text nó sẽ ngược
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CGContextTranslateCTM(context, 0, self.bounds.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    // CTFrameDraw vẽ frame vừa tạo trong 1 context.
    CTFrameDraw((CTFrameRef) ctFrame,context);
}


@end
