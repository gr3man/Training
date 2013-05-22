//
//  TEPickerData.m
//  Exercise5_4
//
//  Created by Tuan Nguyen Anh on 5/19/13.
//  Copyright (c) 2013 Tuấn Nguyễn Anh. All rights reserved.
//

#import "TEPickerData.h"

@implementation TEPickerData

- (id)init{
    if(self = [super init]){
        NSArray *temp = @[@[@"January",@"31"],@[@"February",@"28"],@[@"March",@"31"],@[@"April",@"30"],@[@"May",@"31"],@[@"June",@"30"],@[@"July",@"31"],@[@"August",@"31"],@[@"September",@"30"],@[@"October",@"31"],@[@"November",@"30"],@[@"December",@"31"]];
        month = [[NSMutableArray alloc] initWithArray:temp];
        
        dayOfMonth = [[NSMutableArray alloc] init];
        for(int i = 1; i<=31; i++){
            [dayOfMonth addObject:[NSString stringWithFormat:@"%d",i]];
        }
        year = [[NSMutableArray alloc] init];
        for(int i = 1970; i<= 2100; i++){
            [year addObject:[NSString stringWithFormat:@"%d",i]];
        }
    }
    return self;
}

- (NSMutableArray *)month{
    return month;
}

- (void) setMonth:(NSMutableArray *)mon{
    month = mon;
}

- (NSMutableArray *) dayOfMonth{
    return dayOfMonth;
}

- (void) setDayOfMonth:(NSMutableArray *)dom{
    dayOfMonth = dom;
}

- (NSMutableArray *) year{
    return year;
}

@end
