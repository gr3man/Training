//
//  TECustomView.h
//  Exercise8_2
//
//  Created by Tuấn Nguyễn Anh on 5/14/13.
//  Copyright (c) 2013 Tuấn Nguyễn Anh. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef enum {
	imgSmall,
    imgLarge
} TypeImage;

@interface TECustomView : UIView

{
    NSString *textString;
    TypeImage type;
    UIFont *defaultFont;
    CGRect frameText;
    NSRange numberRange;
    UIFont *spaceFont;
    NSRange leftSpaceRange;
    NSRange rightSpaceRange;
}

@property (retain, nonatomic) NSMutableAttributedString *attString;
@property (nonatomic, strong) UIImageView *imageView;

- (void) setString : (NSString *) text;
- (NSRange) getNumberString;

@end
