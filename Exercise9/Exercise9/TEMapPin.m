//
//  TEMapPin.m
//  Exercise9
//
//  Created by Tuan Nguyen Anh on 5/31/13.
//  Copyright (c) 2013 Tuấn Nguyễn Anh. All rights reserved.
//

#import "TEMapPin.h"

@implementation TEMapPin

@synthesize title;
@synthesize subtitle;
@synthesize coordinate;

- (CLLocationCoordinate2D)coordinate
{
    return coordinate;
}

- (void)setCoordinate:(CLLocationCoordinate2D)newCoordinate {
    
    coordinate = newCoordinate;
}

@end
