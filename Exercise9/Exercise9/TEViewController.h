//
//  TEViewController.h
//  Exercise9
//
//  Created by Tuấn Nguyễn Anh on 5/22/13.
//  Copyright (c) 2013 Tuấn Nguyễn Anh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "TEMapPin.h"

@interface TEViewController : UIViewController <MKMapViewDelegate>

{
    MKMapView *mapv;
    UIToolbar *toolBar;
    UISlider *zoomBar;
}
@property (strong, nonatomic) IBOutlet UISlider *zoomBar;
@property (strong, nonatomic) IBOutlet MKMapView *mapv;
@property (strong, nonatomic) IBOutlet UIToolbar *toolBar;
@property (strong, nonatomic) TEMapPin *start;
@property (strong, nonatomic) TEMapPin *end;
@property (strong, nonatomic) MKPolyline *polyLine;

- (IBAction)zoomMap:(UISlider *)sender;
@end
