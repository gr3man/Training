//
//  TEScrollFilterPicker.h
//  LoadingFilter
//
//  Created by Tuấn Nguyễn Anh on 6/27/13.
//  Copyright (c) 2013 Tuấn Nguyễn Anh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TEImageFiltration.h"

@interface TEScrollFilterPicker : UIScrollView <ImageFiltrationDelegate>
{
    UIImage *imageToFilter;
    UIImage *miniImage;
    NSMutableArray *filteredImages;
    NSOperationQueue *filterQueue;
}

@property (retain, nonatomic) UIImage *imageToFilter;
@property (retain, nonatomic) UIImage *miniImage;
@property (copy, nonatomic) NSMutableArray *filteredImages;
@property (retain, nonatomic) NSOperationQueue *filterQueue;

@end
