//
//  TECTView.m
//  TECoreTextMagazine
//
//  Created by Tuấn Nguyễn Anh on 5/10/13.
//  Copyright (c) 2013 Tuấn Nguyễn Anh. All rights reserved.
//

#import "TECTView.h"
#import <CoreText/CoreText.h>
#import "TEMarkupParser.h"
#import "TECTColumnView.h"

@implementation TECTView

@synthesize attString;
@synthesize frames;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    [super drawRect:rect];
    CGContextRef context = UIGraphicsGetCurrentContext();
    //Core Text gốc tọa độ ở góc dưới bên trái, trục x tăng từ trái sang phải, y tăng từ dưới lên trên, nên khi vẽ text nó sẽ ngược
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CGContextTranslateCTM(context, 0, self.bounds.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    //Tạo một path bao quanh vùng text định vẽ.
    //Ở đây sẽ dùng toàn bộ biên của view để vẽ text bằng cách dùng self.bounds
    CGMutablePathRef path = CGPathCreateMutable();
    //Add a shape to Path, here we add a rectangle, we can create and add other shape with other method
    CGPathAddRect(path, NULL, self.bounds );

    //NSAttributedString thay thế cho NSString trong CoreText cho phép áp dụng các thuộc tính định dạng cho text.
    //Ở đây chỉ tạo NSAttributedString để lưu 1 text, chưa format nó.

    //CTFramesetter quản lý font và frame. CTFramesetterCreateWithAttributedString tạo 1 CTFramesetter và khởi tạo nó với 1 string có các attribute.
    //Sau khi có CTFramesetter sẽ tạo 1 frame dùng CTFramesetterCreateFram với một khoảng các chữ sẽ được render và hình chữ nhật (path) mà text sẽ được vẽ trong đó.
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef) attString);
    CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, [attString length]), path, NULL);
    
    CFRelease(framesetter);
    CFRelease(frame);
    CFRelease(path);
}
*/

- (void) buildFrames{
    //Initialize some property
    frameXOffset = 20;
    frameYOffset = 20;
    self.pagingEnabled = YES;
    self.delegate = self;
    self.frames = [NSMutableArray array];
    
    //Create and add frame
    CGMutablePathRef path = CGPathCreateMutable();
    //Tạo một frame có thể to hoặc nhỏ hơn frame gốc, điểm trung tâm trùng với frame gốc, truyền vào 1 frame gốc các biến X, Y thể hiện độ thay đổi.
    // Biến X đại diện cho thay đổi theo chiều ngang (frame mới có chiều rộng bằng frame cũ trừ 2*X)
    // Biến Y đại diện cho thay đổi theo chiều ngang (frame mới có chiều rộng bằng frame cũ trừ 2*Y)
    CGRect textFrame = CGRectInset(self.bounds, frameXOffset, frameYOffset);
    CGPathAddRect(path, NULL, textFrame);
    
    //NSAttributedString thay thế cho NSString trong CoreText cho phép áp dụng các thuộc tính định dạng cho text.
    //Ở đây chỉ tạo NSAttributedString để lưu 1 text, chưa format nó.
    //CTFramesetter quản lý font và frame. CTFramesetterCreateWithAttributedString tạo 1 CTFramesetter và khởi tạo nó với 1 string có các attribute.
    //Sau khi có CTFramesetter sẽ tạo 1 frame dùng CTFramesetterCreateFram với một khoảng các chữ sẽ được render và hình chữ nhật (path) mà text sẽ được vẽ trong đó.
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef) attString);
    
    //current postion of text
    int textPos = 0;
    //number of column
    int columnIndex = 0;
    
    while (textPos < [attString length]) { //run until end of text
        //Column offset to alignment
        CGPoint colOffset = CGPointMake((columnIndex + 1)*frameXOffset + columnIndex * (textFrame.size.width/2), 20);
        //Create column bounds, it create two column, two column have space = 20
        CGRect colRect = CGRectMake(0, 0, textFrame.size.width/2 - 10, textFrame.size.height - 40);
        
        //Create a path and add column frame to this path
        CGMutablePathRef path = CGPathCreateMutable();
        CGPathAddRect(path, NULL, colRect);
        
        CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(textPos, 0), path, NULL);
        //Tìm ra số lượng text có thể fit vào frame.
        CFRange frameRange = CTFrameGetVisibleStringRange(frame);
        
        TECTColumnView *content = [[[TECTColumnView alloc] initWithFrame:CGRectMake(0, 0, self.contentSize.width, self.contentSize.height)] autorelease];
        content.backgroundColor = [UIColor clearColor];
        content.frame = CGRectMake(colOffset.x, colOffset.y, colRect.size.width, colRect.size.height);
        
        [content setCTFrame:(id)frame];
        [self.frames addObject:(id)frame];
        [self addSubview:content];
        
        //Thay đổi vị trí text tiêp theo
        textPos += frameRange.length;
        //Tăng số lượng cột
        columnIndex++;
    }
    
    //Tổng số trang bằng tổng số cột chia 2.
    int totalPages = (columnIndex + 1) / 2;
    //Đặt lại kích thước của content, bằng tổng số trang nhân với số chiều rộng trước đó của nó (chiều rộng màn hình)
    self.contentSize =  CGSizeMake(totalPages * self.bounds.size.width, textFrame.size.height);
}

- (void) dealloc
{
    self.attString = nil;
    self.frames = nil;
    [super dealloc];
}


@end
