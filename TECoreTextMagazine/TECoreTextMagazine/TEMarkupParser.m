//
//  TEMarkupParser.m
//  TECoreTextMagazine
//
//  Created by Tuấn Nguyễn Anh on 5/10/13.
//  Copyright (c) 2013 Tuấn Nguyễn Anh. All rights reserved.
//

#import "TEMarkupParser.h"

@implementation TEMarkupParser

@synthesize font, color, strokeColor, strokeWidth;
@synthesize images;

- (id) init{
    self = [super init];
    if(self){
        self.font = @"ArialMT";
        self.color = [UIColor blackColor];
        self.strokeColor = [UIColor whiteColor];
        self.strokeWidth = 0.0;
        self.images = [NSMutableArray array];
    }
    
    return self;
}

- (NSAttributedString *) attrStringFromMarkup:(NSString *)html{
    NSMutableAttributedString *aString = [[NSMutableAttributedString alloc] initWithString:@""];
    
    //Biểu thức này đầu tiên tìm bất kỳ ký tự nào tiếp theo đến 1 dấu < rồi các ký tự khác cho đến khi gặp dấu >
    //Ví dụ: "mot hai <ba bon> nam sau <bay>". Sẽ tìm được xâu đầu tiên là "mot hai <ba bon>". Xâu thứ hai là " nam sau <bay>".
    NSRegularExpression *regex = [[NSRegularExpression alloc] initWithPattern:@"(.*?)(<[^>]+>|\\Z)" options:NSRegularExpressionCaseInsensitive | NSRegularExpressionDotMatchesLineSeparators error:nil];
    NSArray *trunk = [regex matchesInString:html options:0 range:NSMakeRange(0, [html length])];
    //Duyệt qua các xâu match, b lưu khoảng các xâu đó.
    for (NSTextCheckingResult *b in trunk) {
        //NSString *test = [html substringWithRange:b.range];
        //Lấy xâu match này cho vào parts, tách xâu này ra 2 phần phần trước là xâu ký tự được hiển thị. Phần sau là đoạn attribute của xâu tiếp theo.
        NSArray *parts = [[html substringWithRange:b.range] componentsSeparatedByString:@"<"];
        CTFontRef fontRef = CTFontCreateWithName((CFStringRef) self.font, 24.0f, NULL);
        
        NSDictionary *attrs = [NSDictionary dictionaryWithObjectsAndKeys:
                               (id) self.color.CGColor, kCTForegroundColorAttributeName,
                               (id) fontRef, kCTFontAttributeName,
                               (id) self.strokeColor.CGColor, (NSString *) kCTStrokeColorAttributeName,
                               (id) [NSNumber numberWithFloat:self.strokeWidth], (NSString *) kCTStrokeWidthAttributeName,
                               nil];
        //Nối xâu ký tự với thuộc tính đã được set vào biến aString.
        [aString appendAttributedString:[[[NSAttributedString alloc] initWithString:[parts objectAtIndex:0] attributes:attrs] autorelease]];
        CFRelease(fontRef);
        //Nếu vẫn còn xâu ký tự sttribute
        if([parts count] > 1){
            NSString *tag = (NSString *) [parts objectAtIndex:1];
            //Thực hiện gán các thuộc tính tượng ứng vào các biến.
            if([tag hasPrefix:@"font"]){
                NSRegularExpression *scolorRegex = [[[NSRegularExpression alloc] initWithPattern:@"(?<=strokeColor=\")\\w+" options:0 error:NULL] autorelease];
                [scolorRegex enumerateMatchesInString:tag options:0 range:NSMakeRange(0, [tag length])usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
                    if ([[tag substringWithRange:result.range] isEqualToString:@"none"]) {
                        self.strokeWidth = 0.0;
                    } else {
                        self.strokeWidth = -3.0;
                        SEL colorSel = NSSelectorFromString([NSString stringWithFormat:@"%@Color",[tag substringWithRange:result.range]]);
                        self.strokeColor = [UIColor performSelector:colorSel];
                    }
                }];
                
                NSRegularExpression *colorRegex = [[[NSRegularExpression alloc] initWithPattern:@"(?<=color=\")\\w+" options:0 error:NULL] autorelease];
                [colorRegex enumerateMatchesInString:tag options:0 range:NSMakeRange(0, [tag length]) usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
                    SEL colorSel = NSSelectorFromString([NSString stringWithFormat: @"%@Color", [tag substringWithRange:result.range]]);
                    self.color = [UIColor performSelector:colorSel];
                }];
                
                NSRegularExpression* faceRegex = [[[NSRegularExpression alloc] initWithPattern:@"(?<=face=\")[^\"]+" options:0 error:NULL] autorelease];
                [faceRegex enumerateMatchesInString:tag options:0 range:NSMakeRange(0, [tag length]) usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop){
                    self.font = [tag substringWithRange:result.range];
                }];
            }
            
            if ([tag hasPrefix:@"img"]) {
                __block NSNumber *width = [NSNumber numberWithInt:0];
                __block NSNumber *height = [NSNumber numberWithInt:0];
                __block NSString *fileName = @"";
                
                NSRegularExpression *widthRegex = [[[NSRegularExpression alloc] initWithPattern:@"(?<=width=\")[^\"]+" options:0 error:NULL] autorelease];
                
            }
        }
    }
    
    [regex release];
    return (NSAttributedString*)aString;
}

- (void) dealloc{
    self.font = nil;
    self.color = nil;
    self.strokeColor = nil;
    self.images = nil;
    
    [super dealloc];
}

@end
