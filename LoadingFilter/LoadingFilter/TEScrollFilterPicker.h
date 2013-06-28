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

- (void) didSelectFilteredImage : (UIImage *) filteredImage;

@end

@interface TEScrollFilterPicker : UIScrollView <ImageFiltrationDelegate>
{
    UIImage *imageToFilter;
    UIImage *miniImage;
    UIImage *displayImage;
    NSMutableArray *filteredImages;
    //BOOL
    NSOperationQueue *filterQueue;
    id <ScrollForFliterDelegate> delegateImage;
    BOOL doneLoad;
    int displayIndex;
}

@property (retain, nonatomic) UIImage *imageToFilter;
@property (retain, nonatomic) UIImage *miniImage;
@property (retain, nonatomic) UIImage *displayImage;
@property (copy, nonatomic) NSMutableArray *filteredImages;
@property (retain, nonatomic) NSOperationQueue *filterQueue;
@property (nonatomic, retain) id <ScrollForFliterDelegate> delegateImage;

- (void)startImageFiltrationForImage:(UIImage *)record atIndex:(int)index;
- (void)chosenFilterImage:(id)sender;

@end
