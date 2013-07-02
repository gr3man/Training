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
#define kSizeOfMiniImg 60

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
        
        displayImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 100, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.width)];
        [displayImage setContentMode:UIViewContentModeScaleAspectFit];

        if (imageToFilter.size.height > imageToFilter.size.width) {
            miniImage = [self imageWithImage:imageToFilter convertToSize:CGSizeMake(kSizeOfMiniImg * imageToFilter.size.width/imageToFilter.size.height, kSizeOfMiniImg)];
        } else {
            miniImage = [self imageWithImage:imageToFilter convertToSize:CGSizeMake(kSizeOfMiniImg, kSizeOfMiniImg * imageToFilter.size.height/imageToFilter.size.width)];
        }
       //miniImage = [self imageWithImage:imageToFilter convertToSize:CGSizeMake(60, 100)];
        
        for (int i=0; i<16; i++) {
            UIImage *tempImg = [[UIImage alloc] init];
            [filteredImages addObject:@[tempImg, @"NO"]];
        }
        
        for (int i=0; i<16; i++) {
            [self startImageFiltrationForImage:miniImage atIndex:i];
        }
        
        self.contentSize = CGSizeMake((kSizeOfMiniImg + 10) * 16 + 10, self.frame.size.height);
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
    CGFloat xOrigin = filtration.index * (kSizeOfMiniImg + 10) + 10;
    //if (count == 15) {
        //if (!startedFilterRealImg)
            //[self filterRealImage];
//        else{
//            [filteredImages replaceObjectAtIndex:filtration.index withObject:@[filtration.image, @"YES"]];
//            NSLog(@"%d", filtration.index);
//        }
    //}
    if (count > 15){
        [filteredImages replaceObjectAtIndex:filtration.index withObject:@[filtration.image, @"YES"]];
        if(displayIndex == filtration.index) {
            //[displayImage setImage:filteredImages[sender.index][0]];
            //[delegateImage didSelectFilteredImage:displayImage];
            [delegateImage didSelectFilteredImage:filteredImages[filtration.index][0] toShow:YES];
        }
    }
    else {
        UIImageView *awesomeView = [[UIImageView alloc] initWithImage:filtration.image];
        [awesomeView setFrame:CGRectMake(xOrigin, 10, kSizeOfMiniImg, kSizeOfMiniImg)];
        [awesomeView setBackgroundColor:[UIColor blackColor]];
        [awesomeView setContentMode:UIViewContentModeScaleAspectFit];
        
        TEButtonDisplayFilter *buttonForFilter = [[TEButtonDisplayFilter alloc] initWithFrame:CGRectMake(xOrigin, 0, kSizeOfMiniImg, kSizeOfMiniImg)];
        [buttonForFilter setImage:filtration.image forState:UIControlStateNormal];
        [buttonForFilter setBackgroundColor:[UIColor blackColor]];
        [buttonForFilter setContentMode:UIViewContentModeScaleAspectFit];
        buttonForFilter.index = filtration.index;
        //displayIndex = filtration.index;
        [buttonForFilter addTarget:self action:@selector(chosenFilterImage:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:buttonForFilter];
    }
//    if(doneLoad){
//        [filteredImages replaceObjectAtIndex:filtration.index withObject:@[filtration.image, @"YES"]];
//        NSLog(@"%f  %d", filtration.image.size.width, filtration.index);
////        if(displayIndex == filtration.index){
////            [delegateImage didSelectFilteredImage:filteredImages[filtration.index][0]];
////        }
//    }
    count++;
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
    BOOL test = YES;
    if ([(NSString *)filteredImages[sender.index][1] isEqualToString:@"NO"])
    {
//        UIActivityIndicatorView *actiIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
//        actiIndicator.center = displayImage.center;
//        actiIndicator.frame = CGRectMake(0.0, 0.0, 40.0, 40.0);
//        [actiIndicator startAnimating];
//        [displayImage addSubview:actiIndicator];
        test = NO;
        [self startImageFiltrationForImage:imageToFilter atIndex:sender.index];
    }
    
    //[displayImage setImage:filteredImages[sender.index][0]];
    [delegateImage didSelectFilteredImage:filteredImages[sender.index][0] toShow:test];
    displayIndex = sender.index;
}

@end
