//
//  TEImageFiltration.m
//  LoadingFilter
//
//  Created by Tuấn Nguyễn Anh on 6/27/13.
//  Copyright (c) 2013 Tuấn Nguyễn Anh. All rights reserved.
//

#import "TEImageFiltration.h"

@implementation TEImageFiltration

- (id) initWithImage:(UIImage *)newImage atIndex:(int)ind delegate:(id<ImageFiltrationDelegate>)theDelegate
{
    if (self = [super init]) {
        self.image = newImage;
        self.index = ind;
        self.delegate = theDelegate;
    }
    return self;
}

- (void)main {
    @autoreleasepool {
        
        if (self.isCancelled)
            return;
        
        UIImage *tempImage = [self.image m01];
        
        if (self.isCancelled)
            return;
        if(tempImage){
            [(NSObject *)self.delegate performSelectorOnMainThread:@selector(imageFiltrationDidFinish:) withObject:self waitUntilDone:NO];
            self.image = tempImage;
        }
    }
    
}

@end
