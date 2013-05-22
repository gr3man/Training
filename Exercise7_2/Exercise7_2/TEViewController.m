//
//  TEViewController.m
//  Exercise7_2
//
//  Created by Tuấn Nguyễn Anh on 4/26/13.
//  Copyright (c) 2013 Tuấn Nguyễn Anh. All rights reserved.
//

#import "TEViewController.h"

@interface TEViewController ()

@end

@implementation TEViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self.customSliderTime setType:sldTime];
    [self.customSliderDate setType:sldDate];
    [self.customSliderDate initValue];
    [self.customSliderTime initValue];
    [self.customSliderDate setDate:[NSDate date]];
    [self.customSliderTime setDate:[NSDate date]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnClicked:(UIButton *)sender {
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSDateComponents *dateComp = [gregorian components: (NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit) fromDate:[self.customSliderDate Date]];
    NSDateComponents *timeComp = [gregorian components:(NSHourCalendarUnit | NSMinuteCalendarUnit) fromDate:[self.customSliderTime Date]];

    NSInteger min = [timeComp minute];
    NSInteger hour = [timeComp hour];
    NSInteger day = [dateComp day];
    NSInteger month = [dateComp month];
    NSInteger year = [dateComp year];
    
    [[[UIAlertView alloc] initWithTitle:@"Time" message:[NSString stringWithFormat:@"%02d/%02d/%04d %02d:%02d", day, month, year, hour, min] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    
}
@end
