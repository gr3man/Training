//
//  TECustomAnnotationView.h
//  Exercise9
//
//  Created by Tuấn Nguyễn Anh on 6/4/13.
//  Copyright (c) 2013 Tuấn Nguyễn Anh. All rights reserved.
//

#import <MapKit/MapKit.h>

@interface TECustomAnnotationView : MKAnnotationView

@property (retain, nonatomic) UIImageView *call;
- (id)initWithAnnotation:(id<MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier;
- (void) hideImage;
@end
