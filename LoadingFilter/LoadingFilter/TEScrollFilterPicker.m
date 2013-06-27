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
@synthesize imageToFilter, filteredImages, filterQueue;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        imageToFilter = [UIImage imageNamed:@"img1.jpg"];
        filterQueue = [NSOperationQueue new];
        [filterQueue setMaxConcurrentOperationCount:3];
        
        for (int i=0; i<15; i++) {
            [self startImageFiltrationForRecord:imageToFilter atIndex:i];
        }
        
        self.contentSize = CGSizeMake(60 * 15, self.frame.size.height);
    }
    
    return self;
}

- (void) filteringImage
{
    NSLog(@"se");
    [filteredImages addObject:[imageToFilter m02]];
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

@end
