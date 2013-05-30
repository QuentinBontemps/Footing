//
//  Parcours.h
//  Footing
//
//  Created by admin on 17/04/13.
//  Copyright (c) 2013 Quentin Bontemps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Trajet.h"

@interface Parcours : Trajet


@property(strong, nonatomic) NSMutableArray *tempsCheckpoint;
@property(strong, nonatomic) NSMutableArray *distanceCheckpoint;

@end
