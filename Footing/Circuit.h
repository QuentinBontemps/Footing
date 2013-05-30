//
//  Circuit.h
//  Footing
//
//  Created by admin on 17/04/13.
//  Copyright (c) 2013 Quentin Bontemps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Trajet.h"

@interface Circuit : Trajet


@property(strong, nonatomic) NSMutableArray *realCheckpoints;
@property(strong, nonatomic) NSMutableArray *tempsTour;

-(NSNumber *) TimeToLast;

@end
