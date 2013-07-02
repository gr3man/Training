//
//  TEScrollFilterPicker.h
//  LoadingFilter
//
//  Created by Tuấn Nguyễn Anh on 6/27/13.
//  Copyright (c) 2013 Tuấn Nguyễn Anh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TEImageFiltration.h"

@protocol ScrollForFliterDelegate <NSObject>

- (void) didSelectFilteredImage : (UIImage *) image toShow : (BOOL) isFilteredImage;

@end

@interface TEScrollFilterPicker : UIScrollView <ImageFiltrationDelegate>
{
    UIImage *imageToFilter;
    UIImage *miniImage;
    UIImageView *displayImage;
    NSMutableArray *filteredImages;
    //UIView *displayView;
    //BOOL
    NSOperationQueue *filterQueue;
    id <ScrollForFliterDelegate> delegateImage;
    BOOL startedFilterRealImg;
    int displayIndex;
}

@property (retain, nonatomic) UIImage *imageToFilter;
@property (retain, nonatomic) UIImage *miniImage;
@property (retain, nonatomic) UIImageView *displayImage;
@property (copy, nonatomic) NSMutableArray *filteredImages;
@property (retain, nonatomic) NSOperationQueue *filterQueue;
@property (nonatomic, retain) id <ScrollForFliterDelegate> delegateImage;

- (void)startImageFiltrationForImage:(UIImage *)record atIndex:(int)index;
- (void)chosenFilterImage:(id)sender;
- (void)filterRealImage;

@end
