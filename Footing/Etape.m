//
//  Etape.m
//  Footing
//
//  Created by admin on 18/04/13.
//  Copyright (c) 2013 Quentin Bontemps. All rights reserved.
//

#import "Etape.h"

@implementation Etape
@synthesize latitude,longitude,annotation;

-(id)initWithCoder:(NSCoder *)aDecoder
{
    if(self = [super init]){
        self.latitude = [aDecoder decodeObjectForKey:@"latitude"];
        self.longitude = [aDecoder decodeObjectForKey:@"longitude"];
        self.annotation = [aDecoder decodeObjectForKey:@"annotation"];
        
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.latitude forKey:@"latitude"];
    [aCoder encodeObject:self.longitude forKey:@"longitude"];
    [aCoder encodeObject:self.annotation forKey:@"annotation"];
    
}

-(id)initWithLatitude:(NSNumber *)pLatitude longitude:(NSNumber *)pLongitude annotation:(NSString *)pAnnotation
{
    self = [super init];
    if(self){
        self.latitude = pLatitude;
        self.longitude = pLongitude;
        self.annotation = pAnnotation;
        
    }
    return self;
}

-(id)initWithLatitude:(NSNumber *)pLatitude longitude:(NSNumber *)pLongitude
{
    self = [self initWithLatitude:pLatitude longitude:pLongitude annotation:nil];
    return self;
}

-(CLLocation *)getLocation
{
    return [[CLLocation alloc]initWithLatitude:latitude.floatValue longitude:longitude.floatValue];
}

@end
