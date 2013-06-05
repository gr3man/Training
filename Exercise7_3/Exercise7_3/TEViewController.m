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
@synthesize customSliderTime, customSliderDate, layoutView;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 60, 42, 21)];
    UILabel *dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 150, 42, 21)];
    [timeLabel setBackgroundColor:[UIColor clearColor]];
    [dateLabel setBackgroundColor:[UIColor clearColor]];
    [timeLabel setText:@"Time"];
    [dateLabel setText:@"Date"];
    
    customSliderTime = [[TECustomSlider alloc] initWithFrame:CGRectMake(68, 60, 234, 23)];
    customSliderDate = [[TECustomSlider alloc] initWithFrame:CGRectMake(68, 150, 234, 23)];
    
    layoutView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200)];
    [layoutView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background_maptools_view.png"]]];
    
    [layoutView addSubview:timeLabel];
    [layoutView addSubview:dateLabel];
    [layoutView addSubview:customSliderDate];
    [layoutView addSubview:customSliderTime];
    
    [customSliderTime setType:sldTime];
    [customSliderDate setType:sldDate];
    [customSliderDate initValue];
    [customSliderTime initValue];
    customSliderDate.ratioZoom = 10;
    customSliderTime.ratioZoom = 40;
    [customSliderDate setDate:[NSDate date]];
    [customSliderTime setDate:[NSDate date]];

    [self.asf setType:sldDate];
    [self.asf initValue];
    [self.asf setDate:[NSDate date]];
    [self.view addSubview:layoutView];
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
//
//- (void) didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation{
//    [customSliderTime changeLocation:fromInterfaceOrientation];
//    [customSliderDate changeLocation:fromInterfaceOrientation];
//}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [customSliderDate hidePopup];
    [customSliderTime hidePopup];
}

@end
