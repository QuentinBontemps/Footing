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

+(UIColor *)getAccueilColor
{
    return [UIColor blackColor];
}

+(UIColor *)getParcoursColor
{
    float r = 223;
    float g = 0;
    float b = 1;
    
    return [UIColor colorWithRed:r/255.f green:g/255.f blue:b/255.f  alpha:1];
}

+(UIColor *)getCircuitsColor
{
    float r = 0;
    float g = 116;
    float b = 255;
    
    return [UIColor colorWithRed:r/255.f green:g/255.f blue:b/255.f  alpha:1];
}

+(UIColor *)getAnciensParcoursColor
{
    float r = 225;
    float g = 154;
    float b = 18;
    
    return [UIColor colorWithRed:r/255.f green:g/255.f blue:b/255.f  alpha:1];
}

+(UIColor *)getStatsColor
{
    float r = 71;
    float g = 0;
    float b = 130;
    
    return [UIColor colorWithRed:r/255.f green:g/255.f blue:b/255.f  alpha:1];
}

+(UIColor *)getParcoursFontColor
{
    return [UIColor whiteColor];
}

+(UIColor *)getCircuitsFontColor
{
    return [UIColor whiteColor];
}

+(UIColor *)getAnciensParcoursFontColor
{
    return [UIColor whiteColor];
}

+(UIColor *)getStatsFontColor
{
    return [UIColor whiteColor];
}


@end
