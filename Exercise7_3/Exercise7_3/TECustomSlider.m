//
//  TECustomSlider.m
//  Exercise7_3
//
//  Created by Tuấn Nguyễn Anh on 6/3/13.
//  Copyright (c) 2013 Tuấn Nguyễn Anh. All rights reserved.
//

#import "TECustomSlider.h"
#import <QuartzCore/QuartzCore.h>

int numberDate[] = {31,28,31,30,31,30,31,31,30,31,30,31};

@implementation TECustomSlider
@synthesize popupMenu, ratioZoom, miniSlider;

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

- (void) setType:(TypeSlider)newType{
    type = newType;
}

- (TypeSlider) Type{
    return type;
}

- (NSDate *) Date{
    return date;
}

- (void) setDate:(NSDate *)newDate{
    date = newDate;
}


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
            [self setMaximumValue:47];
        default:
            break;
    }
    //Đặt giá trị là thời điểm hiện tại
    [self setValue:[self getValueFromTime]];
    previousValue = self.value;    
    [self initUIlable];
    [self addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
}

- (void) initUIlable{
    float coorX = self.frame.origin.x;
    label = [[UILabel alloc] init];
    CGRect frameLabel;
    label.text = [self stringForLabel];
    [label setBackgroundColor:[UIColor clearColor]];
    //Vẽ khung
    label.layer.borderColor = [UIColor blackColor].CGColor;
    
    //Đặt frame cho popup
    popupFrame = CGRectMake(self.frame.origin.x, self.frame.origin.y - 30, self.frame.size.width, 30);
    
    label.layer.borderWidth = 1;
    //Cho phép label có thể click
    UITapGestureRecognizer* gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showPopup)];
    // if labelView is not set userInteractionEnabled, you must do so
    [label setUserInteractionEnabled:YES];
    [label addGestureRecognizer:gesture];
    
    CGFloat fontSize = label.font.pointSize;
    frameLabel.size.height = fontSize;
    //Tính toán kích thước, vị trí label
    switch (type) {
        case sldDate:
            frameLabel.size.width = 88;
            frameLabel.origin.y -= 10;
            coorX += self.value * (self.frame.size.width / (self.maximumValue - self.minimumValue + 38)) - frameLabel.size.width + 4;
            break;
        case sldTime:
            frameLabel.size.width = 45;
            frameLabel.origin.y -= 10;
            coorX += self.value * (self.frame.size.width / (self.maximumValue - self.minimumValue + 5)) - frameLabel.size.width + 5;
        default:
            break;
    }
    //Kiểm tra nếu label bị quá slider thì đặt lại label
    if(coorX < self.frame.origin.x){
        coorX += frameLabel.size.width + 17;
    }
    frameLabel.origin.x = coorX;
    frameLabel.origin.y = self.frame.origin.y - 12;
    [label setFrame:frameLabel];
    [self.superview addSubview:label];

    //Khởi tạo popup menu
    popupMenu = [[TEPopupView alloc] initWithFrame:CGRectMake(self.frame.origin.x - 5, self.frame.origin.y -26 - label.frame.size.height, self.frame.size.width + 10, 30)];
    //popupMenu.alpha = 0.5;
    popupMenu.layer.cornerRadius = 5;
    popupMenu.layer.borderWidth = 1.5f;
    popupMenu.backgroundColor = [UIColor clearColor];
    //customView.layer.borderColor = CGColorCreate(CGColorSpaceCreateDeviceRGB(), YourColorValues);
    popupMenu.layer.masksToBounds = YES;
    
    miniSlider = [[UISlider alloc] initWithFrame: CGRectMake(5, 4, self.frame.size.width, 23)];
    miniSlider.minimumValue = 0;
    miniSlider.maximumValue = lroundf(self.maximumValue / ratioZoom);
    //[popupMenu addSubview:miniSlider];
}

//Gọi ra popup khi click vào label
- (void) showPopup
{
    //miniSlider.value = lroundf(miniSlider.maximumValue / 2);
    
    [self.superview addSubview:popupMenu];
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.4];
    [popupMenu setAlpha:1.0];
    [UIView commitAnimations];
    [UIView setAnimationDuration:0.0];
}

- (void) changeLocation : (UIInterfaceOrientation)orient{
    CGRect frameLabel = label.frame;
    float coorX = 0;
    //Kiểm tra chiều màn hình để ddwatj lại vị trí cho label
    if(UIInterfaceOrientationIsPortrait(orient)){
        if(type == sldTime){
            coorX = self.value * (self.frame.size.width / (self.maximumValue - self.minimumValue + 3)) - frameLabel.size.width + 5;
        } else if(type == sldDate) {
            coorX = self.value * (self.frame.size.width / (self.maximumValue - self.minimumValue + 20)) - frameLabel.size.width + 4;
        }
    }
    else {
        if(type == sldTime){
            coorX = self.value * (self.frame.size.width / (self.maximumValue - self.minimumValue + 5)) - frameLabel.size.width + 5;
        } else if(type == sldDate) {
            coorX = self.value * (self.frame.size.width / (self.maximumValue - self.minimumValue + 38)) - frameLabel.size.width + 4;
        }
    }
    //Kiểm tra label có ra ngoài slider không
    if(coorX < self.frame.origin.x){
        coorX += frameLabel.size.width + 17;
    }
    
    if(coorX + label.frame.size.width > self.frame.size.width){
        coorX -= label.frame.size.width + 17;
    }
    
    frameLabel.origin.x = coorX;
    [label setFrame:frameLabel];
}

- (IBAction) valueChanged:(UISlider *)sender{
    int progress = lroundf(sender.value);
    [self getDateFromInt:progress];
    label.text = [self stringForLabel];
    CGFloat coorX = label.frame.origin.x;
    
    UIInterfaceOrientation interfaceOrientation = [UIApplication sharedApplication].statusBarOrientation;
    if(UIInterfaceOrientationIsLandscape(interfaceOrientation)){
        switch (type) {
            case sldTime:
                coorX += ((sender.value - previousValue) * (self.frame.size.width / (self.maximumValue - self.minimumValue + 3)));
                break;
            case sldDate:
                coorX += ((sender.value - previousValue) * (self.frame.size.width / (self.maximumValue - self.minimumValue + 20)));
                break;
            default:
                break;
        }
    }
    else{
        switch (type) {
            case sldTime:
                coorX += ((sender.value - previousValue) * (self.frame.size.width / (self.maximumValue - self.minimumValue + 5)));
                break;
            case sldDate:
                coorX += ((sender.value - previousValue) * (self.frame.size.width / (self.maximumValue - self.minimumValue + 38)));
                break;
            default:
                break;
        }
    }
    if(coorX < self.frame.origin.x){
        coorX += label.frame.size.width + 17;
    }
    if(coorX + label.frame.size.width > self.frame.size.width + self.frame.origin.x){
        coorX -= label.frame.size.width + 17;
    }
    previousValue = sender.value;
    [label setFrame:CGRectMake(coorX, label.frame.origin.y, label.frame.size.width, label.frame.size.height)];
    //Xóa popup đi
    [popupMenu removeFromSuperview];
}

- (NSString *)stringForLabel{
    //Text cho label
    switch (type) {
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
            hour = value/2;
            min = (value%2) * 30;
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
            if(min<15){
                min = 0;
            } else {
                min = 30;
            }
            temp = hour * 2 + (min/30);
            break;
        default:
            break;
    }
    return temp;
}

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

- (bool)isLeapYear{
    if((year%4 == 0 && year%100 != 0) || year%400 == 0){
        return YES;
    }
    return NO;
}

//- (BOOL) beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{
//    NSLog(@"inside");
//    return [super beginTrackingWithTouch:touch withEvent:event];
//}
//
//- (BOOL) continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{
//    NSLog(@"inmo");
//    return [super continueTrackingWithTouch:touch withEvent:event];
//}

//- (CGRect)trackRectForBounds:(CGRect)bounds
//{
//    return bounds;
//}

@end
