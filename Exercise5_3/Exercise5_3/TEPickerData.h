//
//  TEPickerData.h
//  Exercise5_3
//
//  Created by Tuấn Nguyễn Anh on 5/7/13.
//  Copyright (c) 2013 Tuấn Nguyễn Anh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TEPickerData : NSObject
{
    NSMutableArray *month;
    NSMutableArray *dayOfMonth;
    NSMutableArray *year;
}

- (void) setMonth:(NSMutableArray *)mon;
- (NSMutableArray *)month;
- (void) setDayOfMonth:(NSMutableArray *)dom;
- (NSMutableArray *) dayOfMonth;
- (NSMutableArray *) year;

@end
