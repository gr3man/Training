//
//  TEViewController.m
//  Exercise7
//
//  Created by Tuan Nguyen Anh on 4/23/13.
//  Copyright (c) 2013 Tuan Nguyen Anh. All rights reserved.
//

#import "TEViewController.h"

@interface TEViewController ()

@end

@implementation TEViewController
float currentTime;
float currentDate;
NSInteger year;

int numberDate[] = {31,28,31,30,31,30,31,31,30,31,30,31};

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    NSDate *today = [NSDate date];
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSDateComponents *timeComp = [gregorian components:(NSHourCalendarUnit | NSMinuteCalendarUnit | NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit) fromDate:today];
    
    NSInteger hour = [timeComp hour];
    NSInteger min = [timeComp minute];
    if(min<15){
        min = 0;
    } else {
        min = 30;
    }
    float time = hour * 2 + (min/30);
    float coorX;
    
    [self.sliderTime setValue:time];
    currentTime = time;
    self.labelTime = [[UILabel alloc] init];
    CGRect coorTime = self.sliderTime.frame;
    self.labelTime.text = [NSString stringWithFormat:@"%02d:%02d",hour, min];
    CGFloat fontSize = self.labelTime.font.pointSize;
    coorTime.size.height = fontSize;
    coorTime.size.width = 45;
    coorTime.origin.y -= 10;
    coorX = self.sliderTime.value * (self.sliderTime.frame.size.width / (self.sliderTime.maximumValue - self.sliderTime.minimumValue + 5)) - coorTime.size.width + self.sliderTime.frame.origin.x + 5;
    if(coorX < self.sliderTime.frame.origin.x){
        coorX += self.labelTime.frame.size.width + 17;
    }

    coorTime.origin.x = coorX;
    [self.labelTime setFrame:coorTime];
    [self.labelTime setBackgroundColor:[UIColor clearColor]];
    //[self.labelTime setFrame:coorTime];
    [self.view addSubview:self.labelTime];
    
    NSInteger day = [timeComp day];
    NSInteger month = [timeComp month] - 1;
    year = [timeComp year];
    if(year % 4 == 0){
        numberDate[1] = 29;
        if(year % 100 == 0){
            if (year % 400 != 0) {
                numberDate[1] = 28;
            }
        }
    }
    float temp = day;
    for (int i = 0; i < month; i++) {
        temp += numberDate[i];
    }
    [self.sliderDate setValue:temp];
    currentDate = temp;
    self.labelDate = [[UILabel alloc] init];
    //[self.sliderDate setFrame:CGRectMake(100, 100, 100, 100)];
    CGRect coorDate = self.sliderDate.frame;
    self.labelDate.text = [NSString stringWithFormat:@"%02d/%02d/%4d",day, month + 1, year];
    fontSize = self.labelDate.font.pointSize;
    coorDate.size.height = fontSize;
    coorDate.size.width = 88;
    coorDate.origin.y -= 10;
    coorX = self.sliderDate.value * (self.sliderDate.frame.size.width / (self.sliderDate.maximumValue - self.sliderDate.minimumValue + 38)) - coorDate.size.width + self.sliderDate.frame.origin.x + 4;
    if(coorX < self.sliderDate.frame.origin.x){
        coorX += coorDate.size.width + 17;
    }
    coorDate.origin.x = coorX;
    [self.labelDate setFrame:coorDate];
    [self.labelDate setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:self.labelDate];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

NSString *convertTime(int time){
    int hour = time/2;
    int min = (time%2) * 30;
    return [NSString stringWithFormat:@"%02d:%02d",hour, min];
}

NSString *convertDate(int date){
    int month = 0;
    while(date > numberDate[month]){
        date -= numberDate[month];
        month++;
    }
    return [NSString stringWithFormat:@"%02d/%02d/%4d",date, month+1,year];
}

- (IBAction)timeChanged:(UISlider *)sender {
    int progress = lroundf(sender.value);
    self.labelTime.text = convertTime(progress);
    CGFloat coorX = self.labelTime.frame.origin.x;
    
    UIInterfaceOrientation interfaceOrientation = [UIApplication sharedApplication].statusBarOrientation;
    if(UIInterfaceOrientationIsLandscape(interfaceOrientation)){
        coorX += ((sender.value - currentTime) * (self.sliderTime.frame.size.width / (self.sliderTime.maximumValue - self.sliderTime.minimumValue + 3)));
    } else if(UIInterfaceOrientationIsPortrait(interfaceOrientation)){
        coorX += ((sender.value - currentTime) * (self.sliderTime.frame.size.width / (self.sliderTime.maximumValue - self.sliderTime.minimumValue + 5)));
    }
    
    
    if(coorX < self.sliderTime.frame.origin.x){
        coorX += self.labelTime.frame.size.width + 17;
    }
    if(coorX + self.labelTime.frame.size.width > self.sliderTime.frame.origin.x + self.sliderTime.frame.size.width){
        coorX -= self.labelTime.frame.size.width + 17;
    }
    //NSLog([NSString stringWithFormat:@"%f",(sender.value-currentTime)]);
    [self.labelTime setFrame:CGRectMake(coorX, self.labelTime.frame.origin.y, self.labelTime.frame.size.width, self.labelTime.frame.size.height)];
    currentTime = sender.value;
}

- (IBAction)dateChanged:(UISlider *)sender {
    int progress = lroundf(sender.value);
    self.labelDate.text = convertDate(progress);
    CGFloat coorX = self.labelDate.frame.origin.x;
    UIInterfaceOrientation interfaceOrientation = [UIApplication sharedApplication].statusBarOrientation;
    if(UIInterfaceOrientationIsLandscape(interfaceOrientation)){
        coorX += ((sender.value - currentDate) * (self.sliderDate.frame.size.width / (self.sliderDate.maximumValue - self.sliderDate.minimumValue + 20)));
    } else if(UIInterfaceOrientationIsPortrait(interfaceOrientation)){
        coorX += ((sender.value - currentDate) * (self.sliderDate.frame.size.width / (self.sliderDate.maximumValue - self.sliderDate.minimumValue + 38)));
    }
    
    if(coorX < self.sliderDate.frame.origin.x){
        coorX += self.labelDate.frame.size.width + 17;
    }
    if(coorX + self.labelDate.frame.size.width > self.sliderDate.frame.origin.x + self.sliderDate.frame.size.width){
        coorX -= self.labelDate.frame.size.width + 17;
    }
    [self.labelDate setFrame:CGRectMake(coorX, self.labelDate.frame.origin.y, self.labelDate.frame.size.width, self.labelDate.frame.size.height)];
    currentDate = sender.value;
}


- (void) didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation{
    CGRect coorTime = self.labelTime.frame;
    float coorX;
    if(UIInterfaceOrientationIsPortrait(fromInterfaceOrientation)){
        coorX = self.sliderTime.value * (self.sliderTime.frame.size.width / (self.sliderTime.maximumValue - self.sliderTime.minimumValue + 3)) - coorTime.size.width + self.sliderTime.frame.origin.x + 5;
    }
    else {
        coorX = self.sliderTime.value * (self.sliderTime.frame.size.width / (self.sliderTime.maximumValue - self.sliderTime.minimumValue + 5)) - coorTime.size.width + self.sliderTime.frame.origin.x + 5;
    }
    if(coorX < self.sliderTime.frame.origin.x){
        coorX += self.labelTime.frame.size.width + 17;
    }

    coorTime.origin.x = coorX;
    [self.labelTime setFrame:coorTime];
    
    CGRect coorDate = self.labelDate.frame;
    if(UIInterfaceOrientationIsPortrait(fromInterfaceOrientation)){
        coorX = self.sliderDate.value * (self.sliderDate.frame.size.width / (self.sliderDate.maximumValue - self.sliderDate.minimumValue + 20)) - coorDate.size.width + self.sliderDate.frame.origin.x + 4;
    }
    else {
        coorX = self.sliderDate.value * (self.sliderDate.frame.size.width / (self.sliderDate.maximumValue - self.sliderDate.minimumValue + 38)) - coorDate.size.width + self.sliderDate.frame.origin.x + 4;
    }

    if(coorX < self.sliderDate.frame.origin.x){
        coorX += coorDate.size.width + 17;
    }
    coorDate.origin.x = coorX;
    [self.labelDate setFrame:coorDate];
}

- (NSUInteger)supportedInterfaceOrientations{
    //support all orientation
    return UIInterfaceOrientationMaskAll;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    //when device in lanspace mode, only show landspaceright mode.
    //when device in portrait or portraitupsidedown, only show Portrait mode.
    return UIInterfaceOrientationLandscapeRight | UIInterfaceOrientationPortrait;
}
- (BOOL)shouldAutorotate{
    return YES;
}

@end
