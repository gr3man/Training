//
//  TEScrollFilterPicker.m
//  LoadingFilter
//
//  Created by Tuấn Nguyễn Anh on 6/27/13.
//  Copyright (c) 2013 Tuấn Nguyễn Anh. All rights reserved.
//

#import "TEScrollFilterPicker.h"
#import "UIImage+MTFilter.h"
#import "TEButtonDisplayFilter.h"

@implementation TEScrollFilterPicker
int count;
@synthesize imageToFilter, filteredImages, filterQueue, miniImage, delegateImage, displayImage;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        imageToFilter = [UIImage imageNamed:@"img1.jpg"];
        filterQueue = [NSOperationQueue new];
        [filterQueue setMaxConcurrentOperationCount:3];
        filteredImages = [[NSMutableArray alloc] init];
        startedFilterRealImg = NO;
        displayIndex = 0;
        count = 0;
        
        miniImage = [self imageWithImage:imageToFilter convertToSize:CGSizeMake(100, 100)];
        
        for (int i=0; i<16; i++) {
            UIImage *tempImg = [UIImage imageNamed:@"loading-icon.png"];
            [filteredImages addObject:@[tempImg, @"NO"]];
        }
        
        for (int i=0; i<16; i++) {
            [self startImageFiltrationForImage:miniImage atIndex:i];
        }
        
        self.contentSize = CGSizeMake(80 * 16, self.frame.size.height);
    }
    
    return self;
}

- (void)startImageFiltrationForImage:(UIImage *)record atIndex:(int)index {
    if ([(NSString *)filteredImages[index][1] isEqualToString:@"YES"])
    {
        return;
    }
    TEImageFiltration *imageFiltration = [[TEImageFiltration alloc] initWithImage:record atIndex:index delegate:self];
    [filterQueue addOperation:imageFiltration];
}

- (void) filterRealImage
{
    //int imageShow = self.contentOffset.x / 80;
    startedFilterRealImg = YES;
    for (int i=0; i<16; i++) {
        [self startImageFiltrationForImage:imageToFilter atIndex:i];
    }
}

- (void)imageFiltrationDidFinish:(TEImageFiltration *)filtration {
    CGFloat xOrigin = filtration.index * 80 + 10;
    if (count == 15) {
        //if (!startedFilterRealImg)
            [self filterRealImage];
//        else{
//            [filteredImages replaceObjectAtIndex:filtration.index withObject:@[filtration.image, @"YES"]];
//            NSLog(@"%d", filtration.index);
//        }
    }
    else if (count > 15){
        [filteredImages replaceObjectAtIndex:filtration.index withObject:@[filtration.image, @"YES"]];
        if(displayIndex == filtration.index) {
            [delegateImage didSelectFilteredImage:filteredImages[filtration.index][0]];
        }
        NSLog(@"%d", filtration.index);
    }
//    if(doneLoad){
//        [filteredImages replaceObjectAtIndex:filtration.index withObject:@[filtration.image, @"YES"]];
//        NSLog(@"%f  %d", filtration.image.size.width, filtration.index);
////        if(displayIndex == filtration.index){
////            [delegateImage didSelectFilteredImage:filteredImages[filtration.index][0]];
////        }
//    }
    count++;
    //UIImageView *awesomeView = [[UIImageView alloc] initWithImage:filtration.image];
    TEButtonDisplayFilter *buttonForFilter = [[TEButtonDisplayFilter alloc] initWithFrame:CGRectMake(xOrigin, 0, 60, 60)];
    [buttonForFilter setImage:filtration.image forState:UIControlStateNormal];
    buttonForFilter.index = filtration.index;
    //displayIndex = filtration.index;
    [buttonForFilter addTarget:self action:@selector(chosenFilterImage:) forControlEvents:UIControlEventTouchUpInside];
    //[awesomeView setFrame:CGRectMake(xOrigin, 0, 60, 60)];
    [self addSubview:buttonForFilter];
}

- (UIImage *)imageWithImage:(UIImage *)image convertToSize:(CGSize)size {
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *destImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return destImage;
}

- (void)chosenFilterImage : (TEButtonDisplayFilter *)sender;
{
    [delegateImage didSelectFilteredImage:filteredImages[sender.index][0]];
    displayIndex = sender.index;
}

@end
