//
//  TEMarkupParser.h
//  TECoreTextMagazine
//
//  Created by Tuấn Nguyễn Anh on 5/10/13.
//  Copyright (c) 2013 Tuấn Nguyễn Anh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreText/CoreText.h>

@interface TEMarkupParser : NSObject
{
    NSString *font;
    UIColor *color;
    UIColor *strokeColor;
    float strokeWidth;
    
    NSMutableArray *images;
}

@property (retain, nonatomic) NSString* font;
@property (retain, nonatomic) UIColor *color;
@property (retain, nonatomic) UIColor *strokeColor;
@property (assign, readwrite) float strokeWidth;
@property (retain, nonatomic) NSMutableArray* images;

- (NSAttributedString *) attrStringFromMarkup : (NSString *)html;

@end
