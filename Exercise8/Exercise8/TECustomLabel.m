//
//  TECustomLabel.m
//  Exercise8
//
//  Created by Tuấn Nguyễn Anh on 5/8/13.
//  Copyright (c) 2013 Tuấn Nguyễn Anh. All rights reserved.
//

#import "TECustomLabel.h"

@implementation TECustomLabel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.labelBeforeNumber = [[UILabel alloc] init];
        self.labelAfterNumber = [[UILabel alloc] init];
        self.buttonNumber = [[UIButton alloc] init];
        
        defaultFont = [UIFont fontWithName:@"Helvetica" size:17];
        [self.labelBeforeNumber setFont:defaultFont];
        [self.labelAfterNumber setFont:defaultFont];
        [self.buttonNumber.titleLabel setFont:defaultFont];
        
        self.labelAfterNumber.backgroundColor = [UIColor clearColor];
        self.labelBeforeNumber.backgroundColor = [UIColor clearColor];
        
        [self.labelBeforeNumber setTextAlignment:NSTextAlignmentCenter];
        [self.labelAfterNumber setTextAlignment:NSTextAlignmentCenter];
        [self.buttonNumber.titleLabel setTextAlignment:NSTextAlignmentCenter];
        
        type = imgSmall;
    }
    return self;
}

- (void) setText:(NSString *)text{
    UIImage *img;
    
    [self spitString:text];
    
    [self.labelBeforeNumber setText:leftText];
    [self.labelAfterNumber setText:rightText];
    [self.buttonNumber setTitle:number forState:UIControlStateNormal];

    CGSize sizeLeft = [leftText sizeWithFont:self.labelBeforeNumber.font];
    CGSize sizeRight = [rightText sizeWithFont:self.labelAfterNumber.font];
    CGSize sizeString = [text sizeWithFont:self.labelAfterNumber.font];
    
    [self.labelBeforeNumber setFrame:CGRectMake((self.frame.size.width - sizeString.width)/2, 0, sizeLeft.width, sizeLeft.height)];
    
    if(type == imgSmall){
        img = [UIImage imageNamed:@"icon_notification_normal"];
    } else{
        img = [UIImage imageNamed:@"icon_notification_large"];
    }
    self.image = [[UIImageView alloc] initWithImage:img];
    
    [self.buttonNumber setFrame:CGRectMake(self.labelBeforeNumber.frame.origin.x + self.labelBeforeNumber.frame.size.width, self.labelBeforeNumber.frame.origin.y, self.image.frame.size.width, self.image.frame.size.height + 1)];
    [self.labelAfterNumber setFrame:CGRectMake(self.buttonNumber.frame.origin.x + self.buttonNumber.frame.size.width, 0, sizeRight.width, sizeRight.height)];
    
    [self.buttonNumber setBackgroundImage:img forState:UIControlStateNormal];
    
    [self addSubview:self.labelBeforeNumber];
    [self addSubview:self.buttonNumber];
    [self addSubview:self.labelAfterNumber];
}

- (void) spitString:(NSString *)text{
    NSArray *listItems = [text componentsSeparatedByString:@" "];
    for (NSString *s in listItems) {
        if([s integerValue] > 99){
            type = imgLarge;
            number = s;
            break;
        }
        else if ([s integerValue] > 0){
            number = s;
            break;
        }
    }
    
    listItems = [text componentsSeparatedByString:number];
    leftText = listItems[0];
    rightText = listItems[1];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
