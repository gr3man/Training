//
//  TECustomAnnotationView.m
//  Exercise9
//
//  Created by Tuấn Nguyễn Anh on 6/4/13.
//  Copyright (c) 2013 Tuấn Nguyễn Anh. All rights reserved.
//

#import "TECustomAnnotationView.h"

@implementation TECustomAnnotationView
@synthesize call;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithAnnotation:(id <MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    if (self)
    {
        call = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_you@2x.png"]];
        UIImage *blipImage = [UIImage imageNamed:@"CameraFloating@2x.png"];
        [self setImage:blipImage];
    }
    return self;
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [call setFrame:CGRectMake(5, -self.frame.size.height, call.frame.size.width, call.frame.size.height)];
    [self addSubview:call];
}

- (void) hideImage
{
    [call removeFromSuperview];
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
