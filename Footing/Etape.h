//
//  Etape.h
//  Footing
//
//  Created by admin on 18/04/13.
//  Copyright (c) 2013 Quentin Bontemps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface Etape : NSObject<NSCoding>

@property (nonatomic,strong) NSNumber *latitude;
@property (nonatomic,strong) NSNumber *longitude;
@property (nonatomic,strong) NSString *annotation;

-(id)initWithLatitude:(NSNumber *)pLatitude longitude:(NSNumber *)pLongitude annotation:(NSString *)pAnnotation;
-(id)initWithLatitude:(NSNumber *)pLatitude longitude:(NSNumber *)pLongitude ;

-(CLLocation *)getLocation;

@end
