//
//  Parcours.m
//  Footing
//
//  Created by admin on 17/04/13.
//  Copyright (c) 2013 Quentin Bontemps. All rights reserved.
//

#import "Parcours.h"

@implementation Parcours
@synthesize tempsCheckpoint, distanceCheckpoint;

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
        self.tempsCheckpoint = [aDecoder decodeObjectForKey:@"tempsCheckpoint"];
        self.distanceCheckpoint = [aDecoder decodeObjectForKey:@"distanceCheckpoint"];
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
    [aCoder encodeObject:self.tempsCheckpoint forKey:@"tempsCheckpoint"];
    [aCoder encodeObject:self.distanceCheckpoint forKey:@"distanceCheckpoint"];
    [aCoder encodeObject:self.isUpdatable forKey:@"isUpdatable"];
    [aCoder encodeObject:self.trajets forKey:@"trajets"];
}

@end
