//
//  TEViewController.m
//  Exercise9
//
//  Created by Tuấn Nguyễn Anh on 5/22/13.
//  Copyright (c) 2013 Tuấn Nguyễn Anh. All rights reserved.
//

#import "TEViewController.h"
#import "TEMapPin.h"

@interface TEViewController ()

@end

@implementation TEViewController
@synthesize mapv;
@synthesize toolBar;
@synthesize zoomBar;
@synthesize start;
@synthesize end;
@synthesize polyLine;
CLLocationCoordinate2D annotaitonCoords[2];

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
//    annotaitonCoord.latitude = 21.006137;
//    annotaitonCoord.longitude = 105.843011;
//    MKPointAnnotation *annotationPoint = [[MKPointAnnotation alloc] init];
//    annotationPoint.coordinate = annotaitonCoord;
//    annotationPoint.title = @"Ha Noi";
//    annotationPoint.subtitle = @"HaNoi University of Technology";
    
    annotaitonCoords[0].latitude = 21.005140;
    annotaitonCoords[0].longitude = 105.743011;
    start = [[TEMapPin alloc] init];
    start.coordinate =annotaitonCoords[0];
    start.title = @"Start Point";
    start.subtitle = @"This is where we started!";
    
    annotaitonCoords[1].latitude = 21.005140;
    annotaitonCoords[1].longitude = 105.943011;
    end = [[TEMapPin alloc] init];
    end.coordinate =annotaitonCoords[1];
    end.title = @"End Point";
    end.subtitle = @"This is where we finished!";
    
    [mapv addAnnotation:start];
    [mapv addAnnotation:end];
    
    polyLine = [MKPolyline polylineWithCoordinates:annotaitonCoords count:2];
    [mapv addOverlay:polyLine];
    
    //MKCoordinateSpan span = MKCoordinateSpanMake(0.5, 0.5);
    MKCoordinateRegion hanoi = MKCoordinateRegionMakeWithDistance(annotaitonCoords[0], zoomBar.value * 10000, zoomBar.value * 10000);
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
    mapv.centerCoordinate = userLocation.location.coordinate;
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

- (MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id<MKOverlay>)overlay
{
    if ([overlay isKindOfClass:[MKPolyline class]]) {
        MKPolylineView *line = [[MKPolylineView alloc] initWithPolyline:overlay];
        line.lineWidth = 3;
        line.strokeColor = [[UIColor blueColor] colorWithAlphaComponent:0.7];
        return line;
    }
    return nil;
}

- (void) mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view didChangeDragState:(MKAnnotationViewDragState)newState fromOldState:(MKAnnotationViewDragState)oldState
{
    if (newState == MKAnnotationViewDragStateEnding)
    {
        annotaitonCoords[0] = start.coordinate;
        annotaitonCoords[1] = end.coordinate;
        [mapv removeOverlay:polyLine];
        polyLine = [MKPolyline polylineWithCoordinates:annotaitonCoords count:2];
        [mapv addOverlay:polyLine];
    }
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
