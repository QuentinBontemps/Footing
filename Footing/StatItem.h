//
//  StatItem.h
//  Footing
//
//  Created by admin on 28/05/13.
//  Copyright (c) 2013 Quentin Bontemps. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StatItem : NSObject
{
    
}

@property (strong,nonatomic) NSString *title;
@property (strong,nonatomic) NSString *detail;

-(id)initWithTitle:(NSString *)title andDetail:(NSString *)detail;

@end
