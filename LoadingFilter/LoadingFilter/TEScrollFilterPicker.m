//
//  TEScrollFilterPicker.m
//  LoadingFilter
//
//  Created by Tuấn Nguyễn Anh on 6/27/13.
//  Copyright (c) 2013 Tuấn Nguyễn Anh. All rights reserved.
//

#import "TEScrollFilterPicker.h"
#import "UIImage+MTFilter.h"

@implementation TEScrollFilterPicker
@synthesize imageToFilter, filteredImages, filterQueue, miniImage;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        imageToFilter = [UIImage imageNamed:@"loading-icon.png"];
        filterQueue = [NSOperationQueue new];
        [filterQueue setMaxConcurrentOperationCount:3];
        
        miniImage = [self imageWithImage:imageToFilter convertToSize:CGSizeMake(60, 60)];
        
        for (int i=0; i<15; i++) {
            [self startImageFiltrationForRecord:miniImage atIndex:i];
        }
        
        self.contentSize = CGSizeMake(80 * 15, self.frame.size.height);
    }
    
    return self;
}

- (void)startImageFiltrationForRecord:(UIImage *)record atIndex:(int)index {
    TEImageFiltration *imageFiltration = [[TEImageFiltration alloc] initWithImage:imageToFilter atIndex:index delegate:self];
    [filterQueue addOperation:imageFiltration];
}

- (void)imageFiltrationDidFinish:(TEImageFiltration *)filtration {
    CGFloat xOrigin = filtration.index * 80 + 10;
    UIImageView *awesomeView = [[UIImageView alloc] initWithImage:filtration.image];
    [awesomeView setFrame:CGRectMake(xOrigin, 0, 60, 60)];
    [self addSubview:awesomeView];
}

- (UIImage *)imageWithImage:(UIImage *)image convertToSize:(CGSize)size {
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *destImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return destImage;
}

@end
