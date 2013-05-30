//
//  MapPin.h
//  Footing
//
//  Created by admin on 17/05/13.
//  Copyright (c) 2013 Quentin Bontemps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MapPin : NSObject <MKAnnotation,NSCoding>
{
    CLLocationCoordinate2D coordinate;
    CLLocation *location;
    NSString *title;
    NSString *subtitle;
    
}

@property (nonatomic) CLLocationCoordinate2D coordinate;
@property (nonatomic, strong) CLLocation *location;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *subtitle;
@property (nonatomic,strong) NSNumber *isDepart;
@property (nonatomic,strong) NSNumber *isArrivee;

-(id)initWithCoordinates:(CLLocationCoordinate2D)coordinate placeName:(NSString *)placeName description:(NSString *)description;

@end
