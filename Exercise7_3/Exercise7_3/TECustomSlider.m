//
// TECustomSlider.m
// Exercise7_3
//
// Created by Tuấn Nguyễn Anh on 6/3/13.
// Copyright (c) 2013 Tuấn Nguyễn Anh. All rights reserved.
//

#import "TECustomSlider.h"
#import <QuartzCore/QuartzCore.h>

int numberDate[] = {31,28,31,30,31,30,31,31,30,31,30,31};

@implementation TECustomSlider
@synthesize popupMenu, ratioZoom, button, delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        date = [NSDate date];
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
- (void) setType:(TypeSlider)newType{
    type = newType;
}

- (void) setDate:(NSDate *)newDate{
    date = newDate;
}

- (NSDate *) date
{
    return date;
}

- (void) setFrameContainPopup:(CGRect)frame
{
    frameContainPopup = frame;
}

#pragma mark init
//Khởi tạo Slider
- (void) initValue{
    date = [NSDate date];
    [self getDateComponent:date];
    //Đặt giá trị max, min cho slider
    switch (type) {
        case sldDate:
            [self setMinimumValue:1];
            if([self isLeapYear]){
                [self setMaximumValue:366];
            }else{
                [self setMaximumValue:365];
            }
            break;
        case sldTime:
            [self setMinimumValue:0];
            [self setMaximumValue:1439];
        default:
            break;
    }
    //Đặt giá trị là thời điểm hiện tại
    [self setValue:[self getValueFromTime]];
    previousValue = self.value;
    [self addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
}

- (void) initButtonContainTime{
    float coorX = self.frame.origin.x;
    CGRect frameButton;
    
    button = [[TECustomRoundRectButton alloc] init];
    [button setTitle:[self textForButton] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(showPopup) forControlEvents:UIControlEventTouchUpOutside | UIControlEventTouchUpInside];
    
    CGFloat fontSize = button.titleLabel.font.pointSize + 5;
    frameButton.size.height = fontSize;
    //Tính toán kích thước, vị trí label
    switch (type) {
        case sldDate:
            frameButton.size.width = 88;
            frameButton.origin.y -= 10;
            coorX += self.value * (self.frame.size.width / (self.maximumValue - self.minimumValue + 38)) - frameButton.size.width + 3;
            break;
        case sldTime:
            frameButton.size.width = 45;
            frameButton.origin.y -= 10;
            coorX += self.value * (self.frame.size.width / (self.maximumValue - self.minimumValue + 155)) - frameButton.size.width + 4;
        default:
            break;
    }
    //Kiểm tra nếu label bị quá slider thì đặt lại label
    if(coorX < self.frame.origin.x){
        coorX += frameButton.size.width + 17;
    }
    frameButton.origin.x = coorX;
    frameButton.origin.y = self.frame.origin.y - 19;
    [button setFrame:frameButton];
    [self.superview addSubview:button];
    //CGRect k = self.superview.frame;
}


#pragma mark Popup
//Gọi ra popup khi click vào label
- (void) showPopup
{
    popupMenu = [[TEPopupView alloc] initWithFrame:CGRectMake(self.frame.origin.x + frameContainPopup.origin.x - 5, self.frame.origin.y + frameContainPopup.origin.y -32 - button.frame.size.height, self.frame.size.width + 10, 30)];
    
    [popupMenu setDelegate:self];
    
    popupMenu.miniSlider.minimumValue = self.minimumValue;
    popupMenu.miniSlider.maximumValue = self.maximumValue;
    popupMenu.originalValue = self.value;
    [popupMenu addSlider];
    [popupMenu setFrameforTriangular:(button.frame.origin.x + button.frame.size.width/2 - popupMenu.frame.origin.x - 5)];
    //popupMenu.frameOfTriangular = CG
    [popupMenu showPopup];
    
    popupMenu.midValue = popupMenu.miniSlider.value;
}

//- (void) hidePopup:(UIView *)view
//{
//    for (UIView* subView in view.subviews)
//    {
//        //Kích hoạt tất cả các subView của view chính
//        [subView setUserInteractionEnabled:YES];
//        [popupMenu removeFromSuperview];
//    }
//}

//Slider ở popup thay đổi giá trị
- (void) miniSliderChange:(float)value
{
    self.value = popupMenu.originalValue + (value - popupMenu.midValue)/ratioZoom;
    [self valueChanged:self];
}


//Sự kiện khi giá trị thay đổi
- (IBAction) valueChanged:(UISlider *)sender{
    int progress = lroundf(sender.value);
    [self getDateFromInt:progress];
    [button setTitle:[self textForButton] forState:UIControlStateNormal];
    [delegate selectedTime:[self textForButton]];
    CGFloat coorX = button.frame.origin.x;
    
    //Tính toán vị trí button dựa vào giá trị của slider
    switch (type) {
        case sldTime:
            coorX += ((sender.value - previousValue) * (self.frame.size.width / (self.maximumValue - self.minimumValue + 155)));
            break;
        case sldDate:
            coorX += ((sender.value - previousValue) * (self.frame.size.width / (self.maximumValue - self.minimumValue + 38)));
            break;
        default:
            break;
    }
    
    //Nếu quá
    if(coorX < self.frame.origin.x){
        coorX += button.frame.size.width + 17;
    }
    if(coorX + button.frame.size.width > self.frame.size.width + self.frame.origin.x){
        coorX -= button.frame.size.width + 17;
    }
    previousValue = sender.value;
    [button setFrame:CGRectMake(coorX, button.frame.origin.y, button.frame.size.width, button.frame.size.height)];
    [popupMenu setFrameforTriangular:(button.frame.origin.x + button.frame.size.width/2 - popupMenu.frame.origin.x - 5)];
}

#pragma mark process date

- (NSString *)textForButton{
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

- (void) getDateFromInt:(int)value{
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
-(void) getDateComponent:(NSDate *)dateValue{
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