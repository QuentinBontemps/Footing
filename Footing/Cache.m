//
//  Cache.m
//  Footing
//
//  Created by admin on 06/05/13.
//  Copyright (c) 2013 Quentin Bontemps. All rights reserved.
//

#import "Cache.h"

@implementation Cache

static Cache *_instance = nil;

+(Cache *)instance
{
    if(_instance)return _instance;
    
    @synchronized([Cache class])
    {
        if(!_instance){
            _instance = [[self alloc]init];
        }
        return _instance;
    }
    return nil;
}

-(id)init
{
    if(self = [super init]){
        configuration = [Configuration instance];
        parcoursStore = [[NSMutableArray alloc]init];
        circuitsStore = [[NSMutableArray alloc]init];
    }
    return self;
}

-(void)start
{
    [self unserialize:PARCOURS_STORE];
    [self unserialize:CIRCUITS_STORE];
}

-(void)save
{
    [self serialize:PARCOURS_STORE];
    [self serialize:CIRCUITS_STORE];
}

-(void)unserialize:(int)storeType
{
    switch (storeType) {
        case PARCOURS_STORE:
            parcoursStore = [self loadStore:[self getCacheName:storeType] filename:[configuration getString:@"cache.parcours.filename"]];
            break;
        case CIRCUITS_STORE:
            circuitsStore = [self loadStore:[self getCacheName:storeType] filename:[configuration getString:@"cache.circuits.filename"]];
            break;
        default:
            break;
    }
}

-(NSMutableArray *)loadStore:(NSString *)name filename:(NSString *)filename
{
    NSMutableArray *store = [[NSMutableArray alloc]init];
    GestionFile *readFile = [[GestionFile alloc]init];
    
    NSLog(@"Load Store %@",name);
    
    store = (NSMutableArray *)[readFile readObject:filename];
    
    if(store == nil || store.count == 0){
        NSLog(@"%@ store est vide",name);
        return store = [[NSMutableArray alloc]init];
    }else{
        NSLog(@"Désarchivage terminée pour %@ ",name);
        NSLog(@"store nb : %i",store.count);
    }
    
    return store;
}

-(void)serialize:(int)storeType
{
    switch (storeType) {
        case PARCOURS_STORE:
            [self unloadStore:parcoursStore name:[self getCacheName:storeType] filename:[configuration getString:@"cache.parcours.filename"]];
            break;
        case CIRCUITS_STORE:
            [self unloadStore:circuitsStore name:[self getCacheName:storeType] filename:[configuration getString:@"cache.circuits.filename"]];
            break;
        default:
            break;
    }
}

-(void)unloadStore:(NSMutableArray *)store name:(NSString *)name filename:(NSString *)filename
{
    NSLog(@"unloadStore %@",name);
    NSLog(@"store nb : %i",store.count);
    GestionFile *writeFile = [[GestionFile alloc]init];
    [writeFile writeObject:store filename:filename];
}

-(NSArray *)getCircuits
{
    return circuitsStore;
}

-(NSArray *)getParcours
{
    return parcoursStore;
}

-(void)store:(Trajet *) trajet
{
    NSLog(@"store");
    if([trajet isKindOfClass: [Circuit class]] ){
        [circuitsStore addObject:trajet];
        NSLog(@"Circuit store nb : %i", circuitsStore.count);
    }else if ([trajet isKindOfClass: [Parcours class]]){
        [parcoursStore addObject:trajet];
        NSLog(@"Parcours store nb : %i", parcoursStore.count);
    }
}


-(NSString *)getCacheName:(int)storeType
{
    switch (storeType) {
        case PARCOURS_STORE:
            return @"Parcours";
            break;
        case CIRCUITS_STORE:
            return @"Circuits";
            break;
        default:
            return nil;
            break;
    }
}

-(void)addTrajet:(Trajet *)trajet
{
    if([trajet isKindOfClass:[Parcours class]]){
        [parcoursStore addObject:trajet];
    }else if([trajet isKindOfClass:[Circuit class]]){
        [circuitsStore addObject:trajet];
    }
}

-(void)removeTrajet:(Trajet *)trajet
{
    if([trajet isKindOfClass:[Parcours class]]){
        NSLog(@"nb item before : %i",parcoursStore.count);
        [parcoursStore removeObject:trajet];
        NSLog(@"Trajet supprimé");
        NSLog(@"nb item after : %i",parcoursStore.count);
    }else if([trajet isKindOfClass:[Circuit class]]){
        
        NSLog(@"nb item before : %i",circuitsStore.count);
        [circuitsStore removeObject:trajet];
        NSLog(@"Trajet supprimé");
        
        NSLog(@"nb item after : %i",circuitsStore.count);
    }
}

-(void)addTrajet:(Trajet *)toTrajet addTrajet:(Trajet *)addTrajet
{
    if([toTrajet isKindOfClass:[Parcours class]]){
        [self addParcours:(Parcours *)toTrajet addParcours:(Parcours *)addTrajet];
    }else if([toTrajet isKindOfClass:[Circuit class]]){
        [self addCircuit:(Circuit *)toTrajet addCircuit:(Circuit *)addTrajet];
    }
}

-(void)removeTrajet:(Trajet *)toTrajet removeTrajet:(Trajet *)removeTrajet
{
    if([toTrajet isKindOfClass:[Parcours class]]){
        [self removeParcours:(Parcours *)toTrajet removeParcours:(Parcours *)removeTrajet];
    }
}

-(void)addParcours:(Parcours *)toParcours addParcours:(Parcours *)addParcours
{
    
    int parcoursSelected;
    
    for (int i = 0; i < parcoursStore.count; i++) {
        if([toParcours.dateTrajet.description isEqualToString:[[(Parcours *)[parcoursStore objectAtIndex:i] dateTrajet]description]]){
            parcoursSelected = i;
        }
    }
    
    [[(Parcours *)[parcoursStore objectAtIndex:parcoursSelected] trajets] addObject:addParcours];
}

-(void)removeParcours:(Parcours *)toParcours removeParcours:(Parcours *)removeParcours
{
    int parcoursSelected;
    
    for (int i = 0; i < parcoursStore.count; i++) {
        if([toParcours.dateTrajet.description isEqualToString:[[(Parcours *)[parcoursStore objectAtIndex:i] dateTrajet]description]]){
            parcoursSelected = i;
        }
    }
    
    [[(Parcours *)[parcoursStore objectAtIndex:parcoursSelected] trajets] removeObject:removeParcours];
}

-(void)addCircuit:(Circuit *)toCircuit addCircuit:(Circuit *)addCircuit
{
    int circuitSelected;
    
    for (int i = 0; i < circuitsStore.count; i++) {
        if([toCircuit.dateTrajet.description isEqualToString:[[(Circuit *)[circuitsStore objectAtIndex:i] dateTrajet]description]]){
            circuitSelected = i;
        }
    }
    
    [[(Circuit *)[circuitsStore objectAtIndex:circuitSelected] trajets] addObject:addCircuit];
}

-(BOOL)trajetNameExist:(NSString *)name
{
    for (Circuit *circuit in [self getCircuits]) {
        if([circuit.nom isEqualToString:name])
        {
            return YES;
        }
    }
    
    for (Parcours *parcours in [self getParcours]) {
        if([parcours.nom isEqualToString:name]){
            return YES;
        }
    }
    
    return NO;
}

@end
