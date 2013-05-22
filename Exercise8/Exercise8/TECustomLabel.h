//
//  TECustomLabel.h
//  Exercise8
//
//  Created by Tuấn Nguyễn Anh on 5/8/13.
//  Copyright (c) 2013 Tuấn Nguyễn Anh. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
	imgSmall,
    imgLarge
} TypeImage;

@interface TECustomLabel : UIView

{
    TypeImage type;
    NSString *number;
    NSString *leftText;
    NSString *rightText;
    UIFont *defaultFont;
}

@property (nonatomic, strong) UILabel *labelBeforeNumber;
@property (nonatomic, strong) UILabel *labelAfterNumber;
@property (nonatomic, strong) UIImageView *image;
@property (nonatomic, strong) UIButton *buttonNumber;

- (void) setText:(NSString *)text;
- (void) spitString : (NSString *) text;

@end
