//
//  Tools.m
//  Footing
//
//  Created by admin on 20/05/13.
//  Copyright (c) 2013 Quentin Bontemps. All rights reserved.
//

#import "Tools.h"

@implementation Tools

+(NSString *)distanceToString:(NSNumber *)distance
{
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setMaximumFractionDigits:1];
    [formatter setRoundingMode: NSNumberFormatterRoundUp];
    
    if(distance.floatValue < 1000){
        return [NSString stringWithFormat:@"%@ m",[formatter stringFromNumber:[NSNumber numberWithFloat:distance.floatValue]]];
    }else{
        float nxDistance = round(2.0f * (distance.floatValue /1000)) / 2.0f;
            
        return [NSString stringWithFormat:@"%@ km",[formatter stringFromNumber:[NSNumber numberWithFloat:nxDistance]]];
    }
}

+(NSString *)dateToFullString:(NSDate *)date
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"EEEE dd MMMM YYYY HH:mm"];
    
    return [formatter stringFromDate:date];
}

+(NSString *)secondToString:(int)temps
{
    if(temps < 60){
        return [NSString stringWithFormat:@"%i s",temps];
    }else if(temps < 3600){
        return [NSString stringWithFormat:@"%i min %i s",temps/60,temps % 60];
    }else{
        return [NSString stringWithFormat:@"%i h %i m %i s",temps / 3600,(temps/60)%60,temps % 60];
    }
}

+(NSString *)meterToString:(int)distance
{
    if(distance < 1000){
        return [NSString stringWithFormat:@"%i m",distance];
    }else{
        return [NSString stringWithFormat:@"%i,%i km",distance / 1000, distance % 1000];
    }
}

@end
