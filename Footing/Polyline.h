//
//  Polyline.h
//  Footing
//
//  Created by admin on 17/05/13.
//  Copyright (c) 2013 Quentin Bontemps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface Polyline : MKPolyline

@property (strong, nonatomic) UIColor *color;


+ (Polyline *)polylineWithCoordinates:(CLLocationCoordinate2D *)coords count:(NSUInteger)count color:(UIColor *)color;
+ (Polyline *)polylineWithPoints:(MKMapPoint *)points count:(NSUInteger)count color:(UIColor *)color;

@end
