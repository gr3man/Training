//
//  TEImageFiltration.m
//  LoadingFilter
//
//  Created by Tuấn Nguyễn Anh on 6/27/13.
//  Copyright (c) 2013 Tuấn Nguyễn Anh. All rights reserved.
//

#import "TEImageFiltration.h"
#define SuppressPerformSelectorLeakWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)

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
        
        SEL filterFunc;
        if (self.index >= 10) {
            filterFunc = NSSelectorFromString([NSString stringWithFormat:@"m%d",self.index]);
        } else {
            filterFunc = NSSelectorFromString([NSString stringWithFormat:@"m0%d",self.index]);
        }
        
        if (self.isCancelled)
            return;
        
        UIImage *tempImage;
        SuppressPerformSelectorLeakWarning(tempImage = [self.image performSelector:filterFunc];);
        
        if (self.isCancelled)
            return;
        
        if(tempImage){
            self.image = tempImage;
            [(NSObject *)self.delegate performSelectorOnMainThread:@selector(imageFiltrationDidFinish:) withObject:self waitUntilDone:NO];
        }
    }
    
}

@end
