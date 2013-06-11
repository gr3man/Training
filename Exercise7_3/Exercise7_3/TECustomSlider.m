//
// TECustomSlider.m
// Exercise7_3
//
// Created by Tuấn Nguyễn Anh on 6/3/13.
// Copyright (c) 2013 Tuấn Nguyễn Anh. All rights reserved.
//

#import "TECustomSlider.h"
#import <QuartzCore/QuartzCore.h>
#define NUMBER_MINUTES 1440
#define NUMBER_DAY 365
#define NUMBER_DAY_OF_LEAP_YEAR 365

int numberDate[] = {31,28,31,30,31,30,31,31,30,31,30,31};
float spaceToMiniSlider;

@implementation TECustomSlider
@synthesize popupMenu, ratioZoom, buttonDisplayText, delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        date = [NSDate date];
        [self getDateComponent:date];
        [self addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
        buttonDisplayText = [[TECustomRoundRectButton alloc] init];
        spaceToMiniSlider = 5;
        [self setType:sldDate];
        ratioZoom = 10;
        [buttonDisplayText addTarget:self action:@selector(showPopup) forControlEvents:UIControlEventTouchUpOutside | UIControlEventTouchUpInside];
    }
    return self;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

#pragma mark GetSet
- (void)setType:(TypeSlider)newType{
    type = newType;
    float coorX = self.frame.origin.x;
    CGRect frameButton;
    //Đặt giá trị max, min cho slider
    switch (type) {
        case sldDate:
            [self setMinimumValue:1];
            if([self isLeapYear]){
                [self setMaximumValue:NUMBER_DAY_OF_LEAP_YEAR];
            }else{
                [self setMaximumValue:NUMBER_DAY];
            }
            break;
        case sldTime:
            [self setMinimumValue:0];
            [self setMaximumValue:NUMBER_MINUTES - 1];
        default:
            break;
    }
    //Đặt giá trị là thời điểm hiện tại
    [self setValue:[self getValueFromTime]];
    previousValue = self.value;
    
    [buttonDisplayText setTitle:[self generateStringOfTime] forState:UIControlStateNormal];
    frameButton.size.height = buttonDisplayText.titleLabel.font.pointSize + 5;
    frameButton.size.width = [buttonDisplayText.titleLabel.text sizeWithFont:buttonDisplayText.titleLabel.font].width + 2;

    coorX += ((self.value-self.minimumValue)/(self.maximumValue-self.minimumValue))*(self.frame.size.width-self.currentThumbImage.size.width) - frameButton.size.width + 4;
    //Kiểm tra nếu label bị quá slider thì đặt lại label
    if(coorX < self.frame.origin.x){
        coorX += frameButton.size.width + 17;
    }
    frameButton.origin.x = coorX;
    frameButton.origin.y = self.frame.origin.y - 19;
    [buttonDisplayText setFrame:frameButton];
}

- (void) setDate:(NSDate *)newDate{
    date = newDate;
}

- (NSDate *)date
{
    return date;
}

#pragma mark init
//Khởi tạo Slider
- (void)initValueOfSlider{

}

- (void)initButtonDisplayText{

}

- (void)addButtonToView
{
    [self.superview addSubview:buttonDisplayText];
}

#pragma mark Popup
//Gọi ra popup khi click vào label
- (void)showPopup
{
    popupMenu = [[TEPopupView alloc] initWithFrame:CGRectMake(self.frame.origin.x + self.superview.frame.origin.x - spaceToMiniSlider, self.frame.origin.y + self.superview.frame.origin.y + self.frame.size.height, self.frame.size.width + 2*spaceToMiniSlider, 30)];
    [popupMenu setDelegate:self];
    [popupMenu setSpaceToMinislider:spaceToMiniSlider];
    [popupMenu.miniSlider setMinimumValue:self.minimumValue];
    [popupMenu.miniSlider setMaximumValue:self.maximumValue];
    [popupMenu setOriginalValue:self.value];
    [popupMenu addSlider];
    //(((aSlider.value-aSlider.minimumValue)/(aSlider.maximumValue-aSlider.minimumValu‌​e)) * sliderRange)
    [popupMenu setFrameforTriangular:((self.value-self.minimumValue)/(self.maximumValue-self.minimumValue))*(self.frame.size.width-self.currentThumbImage.size.width) + self.currentThumbImage.size.width/2 - spaceToMiniSlider/2];
    [popupMenu showPopup];
    
    popupMenu.midValue = popupMenu.miniSlider.value;
}

//Slider ở popup thay đổi giá trị
- (void)miniSliderChange:(float)value
{
    self.value = popupMenu.originalValue + (value - popupMenu.midValue)/ratioZoom;
    [self valueChanged:self];
}


//Sự kiện khi giá trị thay đổi
- (IBAction)valueChanged:(UISlider *)sender{
    int progress = lroundf(sender.value);
    [self getTimeFromValue:progress];
    [buttonDisplayText setTitle:[self generateStringOfTime] forState:UIControlStateNormal];
    [delegate selectedTime:[self generateStringOfTime]];
    CGFloat coorX = buttonDisplayText.frame.origin.x;
    
    //Tính toán vị trí button dựa vào giá trị của slider
    coorX = ((self.value-self.minimumValue)/(self.maximumValue-self.minimumValue))*(self.frame.size.width-self.currentThumbImage.size.width) + self.frame.origin.x - buttonDisplayText.frame.size.width+4;
    
    //Nếu quá
    if(coorX < self.frame.origin.x){
        coorX += buttonDisplayText.frame.size.width + 15;
    }
    if(coorX + buttonDisplayText.frame.size.width > self.frame.size.width + self.frame.origin.x){
        coorX -= buttonDisplayText.frame.size.width + 15;
    }
    previousValue = sender.value;
    [buttonDisplayText setFrame:CGRectMake(coorX, buttonDisplayText.frame.origin.y, buttonDisplayText.frame.size.width, buttonDisplayText.frame.size.height)];
    [popupMenu setFrameforTriangular:((self.value-self.minimumValue)/(self.maximumValue-self.minimumValue))*(self.frame.size.width-self.currentThumbImage.size.width) + self.currentThumbImage.size.width/2 - spaceToMiniSlider/2];
}

#pragma mark process date

- (NSString *)generateStringOfTime{
    //Text cho button
    switch (type) {
            //Kiểm tra kiểu slider để trả về text phù hợp
        case sldDate:
            return [NSString stringWithFormat:@"%02d/%02d/%04d",day, month, year];
            break;
            
        case sldTime:
            return [NSString stringWithFormat:@"%02d:%02d",hour, min];
            break;
        default:
            break;
    }
}

- (void)getTimeFromValue:(int)value{
    //Lấy ra các giá trị ngày tháng năm từ value trên slider
    month = 0;
    switch (type) {
        case sldDate:
            while(value > numberDate[month]){
                value -= numberDate[month];
                month++;
            }
            month = month + 1;
            day = value;
            break;
        case sldTime:
            hour = value/60;
            min = value%60;
            break;
        default:
            break;
    }
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSDateComponents *timeComp = [gregorian components:(NSHourCalendarUnit | NSMinuteCalendarUnit | NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit) fromDate:date];
    [timeComp setMinute:min];
    [timeComp setHour:hour];
    [timeComp setDay:day];
    [timeComp setMonth:month];
    [timeComp setYear:year];
    
    date = [gregorian dateFromComponents:timeComp];
}

- (float)getValueFromTime{
    //Lấy giá trị từ thời gian
    float temp;
    switch (type) {
            //Lấy giá trị ngày
        case sldDate:
            //Kiểm tra năm nhuận
            if([self isLeapYear]){
                numberDate[1] = 29;
            }
            temp = day;
            for (int i = 0; i < month - 1; i++) {
                temp += numberDate[i];
            }
            break;
            //Lấy giá trị giờ
        case sldTime:
            temp = hour * 60 + min;
            break;
        default:
            break;
    }
    return temp;
}

//Lấy ngày tháng từ đối tượng NSDate
-(void)getDateComponent:(NSDate *)dateValue{
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSDateComponents *timeComp = [gregorian components:(NSHourCalendarUnit | NSMinuteCalendarUnit | NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit) fromDate:date];
    sec = [timeComp second];
    min = [timeComp minute];
    hour = [timeComp hour];
    day = [timeComp day];
    month = [timeComp month];
    year = [timeComp year];
}

//Kiểm tra năm nhuận
- (bool)isLeapYear{
    if((year%4 == 0 && year%100 != 0) || year%400 == 0){
        return YES;
    }
    return NO;
}

@end