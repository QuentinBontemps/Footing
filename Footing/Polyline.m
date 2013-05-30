//
//  Polyline.m
//  Footing
//
//  Created by admin on 17/05/13.
//  Copyright (c) 2013 Quentin Bontemps. All rights reserved.
//

#import "Polyline.h"

@implementation Polyline
@synthesize color;

-(id)init
{
    if(self = [super init])
    {
        color = [[UIColor alloc]init];
    }
    
    return self;
}


+(Polyline *)polylineWithCoordinates:(CLLocationCoordinate2D *)coords count:(NSUInteger)count color:(UIColor *)color
{
    Polyline *polyline = (Polyline *)[super polylineWithCoordinates:coords count:count];
    [polyline setColor:color];
    
    return polyline;
}

+(Polyline *)polylineWithPoints:(MKMapPoint *)points count:(NSUInteger)count color:(UIColor *)color
{
    Polyline *polyline = (Polyline *)[super polylineWithPoints:points count:count];
    [polyline setColor:color];
    
    return polyline;
}

@end
