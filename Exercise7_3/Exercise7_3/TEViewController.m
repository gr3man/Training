//
//  TEViewController.m
//  Exercise7_3
//
//  Created by Tuấn Nguyễn Anh on 6/3/13.
//  Copyright (c) 2013 Tuấn Nguyễn Anh. All rights reserved.
//

#import "TEViewController.h"

@interface TEViewController ()

@end

@implementation TEViewController
@synthesize customSliderTime, customSliderDate;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [customSliderTime setType:sldTime];
    [customSliderDate setType:sldDate];
    [customSliderDate initValue];
    [customSliderTime initValue];
    customSliderDate.ratioZoom = 10;
    [customSliderDate setDate:[NSDate date]];
    [customSliderTime setDate:[NSDate date]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnClicked:(UIButton *)sender {
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSDateComponents *dateComp = [gregorian components: (NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit) fromDate:[customSliderDate Date]];
    NSDateComponents *timeComp = [gregorian components:(NSHourCalendarUnit | NSMinuteCalendarUnit) fromDate:[customSliderTime Date]];
    
    NSInteger min = [timeComp minute];
    NSInteger hour = [timeComp hour];
    NSInteger day = [dateComp day];
    NSInteger month = [dateComp month];
    NSInteger year = [dateComp year];
    
    [[[UIAlertView alloc] initWithTitle:@"Time" message:[NSString stringWithFormat:@"%02d/%02d/%04d %02d:%02d", day, month, year, hour, min] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    
}

- (void) didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation{
    [customSliderTime changeLocation:fromInterfaceOrientation];
    [customSliderDate changeLocation:fromInterfaceOrientation];
}

@end
