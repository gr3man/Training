//
//  TECustomSlider.m
//  Exercise7_2
//
//  Created by Tuan Nguyen Anh on 4/27/13.
//  Copyright (c) 2013 Tuấn Nguyễn Anh. All rights reserved.
//

#import "TECustomSlider.h"

int numberDate[] = {31,28,31,30,31,30,31,31,30,31,30,31};

@implementation TECustomSlider

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


- (void) initValue{
    date = [NSDate date];
    [self getDateComponent:date];
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
    [self setValue:[self getValueFromTime]];
    previousValue = self.value;
    [self initUIlable];
    [self addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
}

- (void) initUIlable{
    float coorX;
    label = [[UILabel alloc] init];
    CGRect frameLabel;
    label.text = [self stringForLabel];
    [label setBackgroundColor:[UIColor clearColor]];
    CGFloat fontSize = label.font.pointSize;
    frameLabel.size.height = fontSize;
    switch (type) {
        case sldDate:
            frameLabel.size.width = 88;
            frameLabel.origin.y -= 10;
            coorX = self.value * (self.frame.size.width / (self.maximumValue - self.minimumValue + 38)) - frameLabel.size.width + 4;
            break;
        case sldTime:
            frameLabel.size.width = 45;
            frameLabel.origin.y -= 10;
            coorX = self.value * (self.frame.size.width / (self.maximumValue - self.minimumValue + 5)) - frameLabel.size.width + 5;
        default:
            break;
    }
    if(coorX < self.frame.origin.x){
        coorX += frameLabel.size.width + 17;
    }
    frameLabel.origin.x = coorX;
    [label setFrame:frameLabel];
    [self addSubview:label];
}

- (IBAction) valueChanged:(UISlider *)sender{
    int progress = lroundf(sender.value);
    [self getDateFromInt:progress];
    label.text = [self stringForLabel];
    CGFloat coorX = label.frame.origin.x;
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
    if(coorX < 0){
        coorX += label.frame.size.width + 17;
    }
    if(coorX + label.frame.size.width > self.frame.size.width){
        coorX -= label.frame.size.width + 17;
    }
    previousValue = sender.value;
    [label setFrame:CGRectMake(coorX, label.frame.origin.y, label.frame.size.width, label.frame.size.height)];
}

- (NSString *)stringForLabel{
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
    float temp;
    switch (type) {
        case sldDate:
            if([self isLeapYear]){
                numberDate[1] = 29;
            }
            temp = day;
            for (int i = 0; i < month - 1; i++) {
                temp += numberDate[i];
            }
            break;
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

@end
