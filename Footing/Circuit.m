//
//  Circuit.m
//  Footing
//
//  Created by admin on 17/04/13.
//  Copyright (c) 2013 Quentin Bontemps. All rights reserved.
//

#import "Circuit.h"

@implementation Circuit
@synthesize realCheckpoints,tempsTour;


-(id)initWithCoder:(NSCoder *)aDecoder
{
    if(self = [super init]){
        self.depart = [aDecoder decodeObjectForKey:@"depart"];
        self.arrivee = [aDecoder decodeObjectForKey:@"arrivee"];
        self.distance = [aDecoder decodeObjectForKey:@"distance"];
        self.checkpoints = [aDecoder decodeObjectForKey:@"checkpoints"];
        self.dateTrajet = [aDecoder decodeObjectForKey:@"dateTrajet"];
        self.tempsTrajet = [aDecoder decodeObjectForKey:@"tempsTrajet"];
        self.vitesseMoyenne = [aDecoder decodeObjectForKey:@"vitesseMoyenne"];
        self.trajetReel = [aDecoder decodeObjectForKey:@"trajetReel"];
        self.nom = [aDecoder decodeObjectForKey:@"nom"];
        self.tempsTour = [aDecoder decodeObjectForKey:@"tempsTour"];
        self.realCheckpoints = [aDecoder decodeObjectForKey:@"realCheckpoints"];
        self.isUpdatable = [aDecoder decodeObjectForKey:@"isUpdatable"];
        self.trajets = [aDecoder decodeObjectForKey:@"trajets"];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.depart forKey:@"depart"];
    [aCoder encodeObject:self.arrivee forKey:@"arrivee"];
    [aCoder encodeObject:self.distance forKey:@"distance"];
    [aCoder encodeObject:self.checkpoints forKey:@"checkpoints"];
    [aCoder encodeObject:self.dateTrajet forKey:@"dateTrajet"];
    [aCoder encodeObject:self.tempsTrajet forKey:@"tempsTrajet"];
    [aCoder encodeObject:self.vitesseMoyenne forKey:@"vitesseMoyenne"];
    [aCoder encodeObject:self.trajetReel forKey:@"trajetReel"];
    [aCoder encodeObject:self.nom forKey:@"nom"];
    [aCoder encodeObject:self.tempsTour forKey:@"tempsTour"];
    [aCoder encodeObject:self.realCheckpoints forKey:@"realCheckpoints"];
    [aCoder encodeObject:self.isUpdatable forKey:@"isUpdatable"];
    [aCoder encodeObject:self.trajets forKey:@"trajets"];
}


/*-(id)initWithDepart:(Etape *)pDepart arrivee:(Etape *)pArrivee distance:(NSNumber *)pDistance checkpoints:(NSMutableArray *)pCheckpoints realCheckpoints:(NSMutableArray *)pRealCheckpoints nom:(NSString *)pNom
{
    self = [super initWithDepart:pDepart arrivee:pArrivee distance:pDistance checkpoints:pCheckpoints nom:pNom];
    if(self){
        realCheckpoints = pRealCheckpoints;
    }
    return self;
}*/

-(id)init
{
    if(self = [super init])
    {
        tempsTour = [[NSMutableArray alloc]init];
    }
    return self;
}

@end
