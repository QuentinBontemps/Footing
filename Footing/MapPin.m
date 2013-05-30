//
//  MapPin.m
//  Footing
//
//  Created by admin on 17/05/13.
//  Copyright (c) 2013 Quentin Bontemps. All rights reserved.
//

#import "MapPin.h"

@implementation MapPin
@synthesize coordinate,title,subtitle,location,isDepart, isArrivee;


- (void) encodeWithCoder: (NSCoder *)coder
{
    [coder encodeObject:self.title forKey:@"title"];
    [coder encodeObject:self.subtitle forKey:@"subtitle"];
    self.location = [[CLLocation alloc]initWithLatitude:self.coordinate.latitude longitude:self.coordinate.longitude];
    [coder encodeObject:self.location forKey:@"location"];
    [coder encodeObject:self.isDepart forKey:@"isDepart"];
    [coder encodeObject:self.isArrivee forKey:@"isArrivee"];
}
- (id) initWithCoder: (NSCoder *)coder
{
    if (self = [super init])
    {   self.title = [coder decodeObjectForKey:@"title"];
        self.subtitle = [coder decodeObjectForKey:@"subtitle"];
        self.location = [coder decodeObjectForKey:@"location"];
        self.coordinate = location.coordinate;
        self.isDepart = [coder decodeObjectForKey:@"isDepart"];
        self.isArrivee = [coder decodeObjectForKey:@"isArrivee"];
    }
    return self;
}

-(id)initWithCoordinates:(CLLocationCoordinate2D)aCoordinates placeName:(NSString *)placeName description:(NSString *)description
{
    self = [super init];
    if(self){
        coordinate = aCoordinates;
        title = placeName;
        subtitle = description;
        self.isDepart = [NSNumber numberWithBool:NO];
        self.isArrivee = [NSNumber numberWithBool:NO];
    }
    return self;
}


@end
