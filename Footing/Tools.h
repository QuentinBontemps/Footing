//
//  Tools.h
//  Footing
//
//  Created by admin on 20/05/13.
//  Copyright (c) 2013 Quentin Bontemps. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Tools : NSObject

+(NSString *)distanceToString:(NSNumber *)distance;
+(NSString *)dateToFullString:(NSDate *)date;
+(NSString *)secondToString:(int)temps;
+(NSString *)meterToString:(int)distance;

@end
