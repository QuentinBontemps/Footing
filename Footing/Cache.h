//
//  Cache.h
//  Footing
//
//  Created by admin on 06/05/13.
//  Copyright (c) 2013 Quentin Bontemps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GestionFile.h"
#import "Parcours.h"
#import "Circuit.h"
#import "Constant.h"
#import "Configuration.h"

@interface Cache : NSObject
{
    NSMutableArray *circuitsStore;
    NSMutableArray *parcoursStore;
    Configuration *configuration;
}
+(Cache *)instance;

-(void)start;
-(void)save;
//TEST GIT
-(void)store:(Trajet *) trajet;

-(void)serialize:(int)storeType;
-(void)unserialize:(int)storeType;

-(NSMutableArray *)loadStore:(NSString *)name filename:(NSString *)filename;
-(void)unloadStore:(NSMutableArray *)store name:(NSString *)name filename:(NSString *)filename;

-(NSString *)getCacheName:(int)storeType;

-(NSArray *)getCircuits;
-(NSArray *)getParcours;

-(void)addTrajet:(Trajet *)trajet;
-(void)removeTrajet:(Trajet *)trajet;

-(void)addTrajet:(Trajet *)toTrajet addTrajet:(Trajet *)addTrajet;
-(void)removeTrajet:(Trajet *)toTrajet removeTrajet:(Trajet *)removeTrajet;

@end
