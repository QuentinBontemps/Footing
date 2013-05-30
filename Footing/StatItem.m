//
//  StatItem.m
//  Footing
//
//  Created by admin on 28/05/13.
//  Copyright (c) 2013 Quentin Bontemps. All rights reserved.
//

#import "StatItem.h"

@implementation StatItem
@synthesize title,detail;

-(id)initWithTitle:(NSString *)pTitle andDetail:(NSString *)pDetail
{
    if(self = [super init])
    {
        title = pTitle;
        detail = pDetail;
    }
    return self;
}

@end
