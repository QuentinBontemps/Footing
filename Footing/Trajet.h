//
//  Trajet.h
//  Footing
//
//  Created by admin on 17/04/13.
//  Copyright (c) 2013 Quentin Bontemps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Etape.h"

@interface Trajet : NSObject<NSCoding>
{

}

@property(strong, nonatomic) NSString *nom;
@property(strong, nonatomic) Etape *depart;
@property(strong, nonatomic) Etape *arrivee;
@property(strong, nonatomic) NSNumber *distance;
@property(strong, nonatomic) NSMutableArray *checkpoints;
@property(strong, nonatomic) NSDate *dateTrajet;
@property(strong, nonatomic) NSNumber *tempsTrajet;
@property(strong, nonatomic) NSNumber *vitesseMoyenne;
@property(strong, nonatomic) NSMutableArray *trajetReel;
@property(strong, nonatomic) NSNumber *isUpdatable;
@property(strong, nonatomic) NSMutableArray *trajets;


-(int)getTrajetsNumber;

@end
