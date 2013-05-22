//
//  TEViewController.m
//  Exercise9
//
//  Created by Tuấn Nguyễn Anh on 5/22/13.
//  Copyright (c) 2013 Tuấn Nguyễn Anh. All rights reserved.
//

#import "TEViewController.h"

@interface TEViewController ()

@end

@implementation TEViewController
@synthesize mapv;
@synthesize toolBar;
@synthesize zoomBar;
CLLocationCoordinate2D annotaitonCoord;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    //mapView.showsUserLocation = YES;
    UIBarButtonItem *zoomButton = [[UIBarButtonItem alloc]
                                   initWithTitle:@"Zoom"
                                   style:UIBarButtonItemStyleBordered
                                   target:self action:@selector(zoomIn:)];
    
    UIBarButtonItem *typeButton = [[UIBarButtonItem alloc]
                                   initWithTitle:@"Type"
                                   style:UIBarButtonItemStyleBordered
                                   target:self action:@selector(changeMapType:)];
    
    NSArray *buttons = [[NSArray alloc] initWithObjects:zoomButton, typeButton, nil];
    toolBar.items = buttons;
    
    //annotaitonCoord = CLLocationCoordinate2DMake(21.037884,105.850182);
    annotaitonCoord.latitude = 21.006137;
    annotaitonCoord.longitude = 105.843011;
    MKPointAnnotation *annotationPoint = [[MKPointAnnotation alloc] init];
    annotationPoint.coordinate = annotaitonCoord;
    annotationPoint.title = @"Ha Noi";
    annotationPoint.subtitle = @"HaNoi University of Technology";
    
    annotaitonCoord.latitude = 21.006140;
    annotaitonCoord.longitude = 105.843011;
    MKPointAnnotation *annotationPoint1 = [[MKPointAnnotation alloc] init];
    annotationPoint1.coordinate = annotaitonCoord;
    annotationPoint1.title = @"Ha Noi";
    annotationPoint1.subtitle = @"HaNoi University";
    
    [mapv addAnnotation:annotationPoint];
    [mapv addAnnotation:annotationPoint1];
    //MKCoordinateSpan span = MKCoordinateSpanMake(0.5, 0.5);
    MKCoordinateRegion hanoi = MKCoordinateRegionMakeWithDistance(annotaitonCoord, zoomBar.value * 10000, zoomBar.value * 10000);
    [mapv setRegion:hanoi];
}

- (void)zoomIn: (id)sender
{
    MKUserLocation *userLocation = mapv.userLocation;
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(userLocation.location.coordinate, 50, 50);
    [mapv setRegion:region animated:YES];
}

- (void) changeMapType: (id) sender
{
    if(mapv.mapType == MKMapTypeStandard){
        mapv.mapType = MKMapTypeSatellite;
    } else
        mapv.mapType = MKMapTypeStandard;
}

- (void) mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    self.mapv.centerCoordinate = userLocation.location.coordinate;
}

- (MKAnnotationView *) mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    static NSString *reuseId = @"pin";
    MKPinAnnotationView *pav = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:reuseId];
    if (pav == nil)
    {
        pav = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:reuseId];
        pav.draggable = YES;
        pav.canShowCallout = YES;
    }
    else
    {
        pav.annotation = annotation;
    }
    
    return pav;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)zoomMap:(UISlider *)sender {
    MKCoordinateRegion hanoi = MKCoordinateRegionMakeWithDistance(mapv.region.center, zoomBar.value * 10000, zoomBar.value * 10000);
    [mapv setRegion:hanoi];
}
@end
