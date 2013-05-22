//
//  TECustomView.m
//  Exercise8_2
//
//  Created by Tuấn Nguyễn Anh on 5/14/13.
//  Copyright (c) 2013 Tuấn Nguyễn Anh. All rights reserved.
//

#import "TECustomView.h"
#import <CoreText/CoreText.h>

@implementation TECustomView

@synthesize attString;
@synthesize imageView;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        defaultFont = [UIFont fontWithName:@"Helvetica" size:17];
        spaceFont = defaultFont;
        self.backgroundColor = [UIColor clearColor];
        type = imgSmall;
        leftSpaceRange = NSMakeRange(0, 0);
        rightSpaceRange = NSMakeRange(0, 0);
    }
    return self;
}

- (void) setString:(NSString *)text{
    
    textString = text;
    numberRange = [self getNumberString];
    NSString *leftString = [textString substringWithRange:NSMakeRange(0, numberRange.location)];
    //NSString *rightString = [textString substringWithRange:NSMakeRange(numberRange.location + numberRange.length, numberRange.location)];
    NSString *num = [textString substringWithRange:numberRange];
    CGSize numSize = [num sizeWithFont:defaultFont];
    
    //Xác định loại hình
    if(numberRange.length == 3){
        imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_notification_large.png"]];
    } else {
        imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_notification_normal.png"]];
    }
    
    float width = [textString sizeWithFont:defaultFont].width;
    float height = [textString sizeWithFont:defaultFont].height;
    NSString *space = @" ";
    
    NSString *temp = num;
    NSString *leftSpace = @"";
    NSString *rightSpace = @"";
    if ([[textString substringWithRange:NSMakeRange(numberRange.location - 1, 1)] isEqualToString:space]){
        temp = [NSString stringWithFormat:@"%@%@",space,temp];
        leftSpaceRange = NSMakeRange(numberRange.location - 1, 1);
        leftSpace = @" ";
    }
    if(numberRange.location + numberRange.length < [textString length]){
        if ([[textString substringWithRange:NSMakeRange(numberRange.location + numberRange.length, 1)] isEqualToString:space] ){
            temp = [NSString stringWithFormat:@"%@%@",temp,space];
            rightSpaceRange = NSMakeRange(numberRange.location + numberRange.length, 1);
            rightSpace = @" ";
        }
    }
    
    //Nếu hình đè chữ
    int rangeSpace = [leftSpace sizeWithFont:defaultFont].width;
    if(((leftSpaceRange.length != 0) && (imageView.frame.size.width/2 > [leftSpace sizeWithFont:defaultFont].width + [num sizeWithFont:defaultFont].width / 2)) || ( (rightSpaceRange.length != 0) && (imageView.frame.size.width/2 > [rightSpace sizeWithFont:defaultFont].width + [num sizeWithFont:defaultFont].width / 2))){
        
        spaceFont = [UIFont fontWithName:@"Helvetica" size:35];
        width += [space sizeWithFont:spaceFont].width;
        height = [space sizeWithFont:spaceFont].height + 15;
        rangeSpace = [leftSpace sizeWithFont:spaceFont].width;
    }
    
    //Tính toán vị trí hình và frame chữ
    //diff: khoảng cách từ chữ đến khung
    float diffX = (self.bounds.size.width - width) / 2;
    float diffY = (self.bounds.size.height - height)/2;
    float centerX = diffX + [leftString sizeWithFont:defaultFont].width - [leftSpace sizeWithFont:defaultFont].width + rangeSpace + numSize.width/2;
    //coor: tọa độ hình
    float coorX = centerX - imageView.frame.size.width/2 - 1;
    float coorY = self.bounds.size.height/2 - imageView.frame.size.height/2;
    [imageView setFrame:CGRectMake(coorX, coorY, imageView.frame.size.width, imageView.frame.size.height)];
    [imageView setFrame:CGRectMake(coorX, coorY, imageView.frame.size.width, imageView.frame.size.height)];
    frameText = CGRectMake(diffX, diffY, width , height);
}

- (NSRange)getNumberString{
    bool hasNumber = NO;
    int loc = 0;
    int len = 0;
    //Tìm chữ số đầu tiên
    for (int i = 0; i < [textString length]; i++){
        char c = [textString characterAtIndex:i];
        if(c>='0' && c<='9')
        {
            loc = i;
            hasNumber = YES;
            break;
        }
    }
    
    //Tìm các chữ số tiếp theo
    if(hasNumber){
        for( int i = loc; i < [textString length]; i++){
            char c = [textString characterAtIndex:i];
            if(c >= '0' && c<='9')
            {
                len++;
            }
            else{
                break;
            }
        }
    }
    
    return NSMakeRange(loc, len);
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
     
     CGMutablePathRef path = CGPathCreateMutable();
     CGPathAddRect(path, NULL, frameText);
     
     CTFontRef fontRef = (CTFontRef) defaultFont;
     
     NSDictionary *attrDictionaryBlack = [NSDictionary dictionaryWithObjectsAndKeys:
                                          (id)fontRef,kCTFontAttributeName,
                                          (id)[[UIColor blackColor] CGColor], kCTForegroundColorAttributeName,
                                          nil];
     
     NSDictionary *attrDictionaryBlue = [NSDictionary dictionaryWithObjectsAndKeys:
                                          (id)fontRef,kCTFontAttributeName,
                                          (id)[[UIColor blueColor] CGColor], kCTForegroundColorAttributeName,
                                          nil];
     CFRelease(fontRef);
     
     attString = [[NSMutableAttributedString alloc] initWithString:textString attributes:attrDictionaryBlack];
     [attString addAttributes:attrDictionaryBlue range:numberRange];
     
     CTFontRef tempFontRef = (CTFontRef) spaceFont;
     NSDictionary *attrDictionarySpace= [NSDictionary dictionaryWithObjectsAndKeys:
                                         (id)tempFontRef,kCTFontAttributeName,
                                         (id)[[UIColor blackColor] CGColor], kCTForegroundColorAttributeName,
                                         nil];
     CFRelease(tempFontRef);
     
     if(leftSpaceRange.length != 0){
         [attString addAttributes:attrDictionarySpace range:leftSpaceRange];
     }
     if(rightSpaceRange.length != 0){
         [attString addAttributes:attrDictionarySpace range:rightSpaceRange];
     }
     
     CTFramesetterRef framsetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attString);
     CTFrameRef frame = CTFramesetterCreateFrame(framsetter, CFRangeMake(0, [attString length]), path, NULL);
     
     [attString release];
     CFRelease(framsetter);
     CFRelease(path);
     
     CTFrameDraw(frame, context);
     CFRelease(frame);
 }



@end
