//
//  TEImageFiltration.h
//  LoadingFilter
//
//  Created by Tuấn Nguyễn Anh on 6/27/13.
//  Copyright (c) 2013 Tuấn Nguyễn Anh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIImage+MTFilter.h"


@protocol ImageFiltrationDelegate;

@interface TEImageFiltration : NSOperation

@property (nonatomic, strong) UIImage *image;
@property (assign, nonatomic) int index;
@property (nonatomic, weak) id <ImageFiltrationDelegate> delegate;

- (id)initWithImage:(UIImage *)newImage atIndex:(int)ind delegate:(id<ImageFiltrationDelegate>)theDelegate;

@end

@protocol ImageFiltrationDelegate <NSObject>
- (void)imageFiltrationDidFinish:(TEImageFiltration *)filtration;
@end

