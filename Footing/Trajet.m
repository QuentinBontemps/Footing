//
//  Trajet.m
//  Footing
//
//  Created by admin on 17/04/13.
//  Copyright (c) 2013 Quentin Bontemps. All rights reserved.
//

#import "Trajet.h"

@implementation Trajet
@synthesize depart,arrivee,distance,checkpoints,dateTrajet,tempsTrajet,vitesseMoyenne,trajetReel,nom,isUpdatable,trajets;

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
    [aCoder encodeObject:self.isUpdatable forKey:@"isUpdatable"];
    [aCoder encodeObject:self.trajets forKey:@"trajets"];
}


-(id)init
{
    if(self = [super init]){
        trajetReel = [[NSMutableArray alloc]init];
        checkpoints = [[NSMutableArray alloc]init];
        isUpdatable = [NSNumber numberWithBool:YES];
        trajets = [[NSMutableArray alloc]init];
    }
    return self;
}

-(int)getTrajetsNumber
{
    return trajets.count + 1;
}

@end
