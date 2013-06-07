//
//  Configuration.m
//  Footing
//
//  Created by admin on 06/05/13.
//  Copyright (c) 2013 Quentin Bontemps. All rights reserved.
//

#import "Configuration.h"

@implementation Configuration


static Configuration *_instance = nil;

+(Configuration *)instance
{
    if(_instance)return _instance;
    
    @synchronized([Configuration class])
    {
        if(!_instance){
            _instance = [[self alloc]init];
        }
        return _instance;
    }
    return nil;
}


- (id)init
{
    self = [super init];
    if (self) {
        items = [[NSMutableDictionary alloc]init];
    }
    return self;
}
-(void)start
{
    NSNumber *yes,*no;
    yes = [NSNumber numberWithBool:true];
    no = [NSNumber numberWithBool:false];
    
    
    NSLog(@"Configuration : start");
    
    [self put:@"app.initialized" item:no];
    [self put:@"app" item:@"debut"];
    
    
    // Cache ----------------------------------------------------------------
    [self put:@"cache.parcours.filename" item:@"footingCache_parcours.txt"];
    [self put:@"cache.circuits.filename" item:@"footingCache_circuit.txt"];
}

-(void)put:(NSString *)key item:(NSObject *)item
{
    [items setObject:item forKey:key];
}
    
-(BOOL)getBoolean:(NSString *)key
{
    return [[items objectForKey:key]boolValue];
}
          
-(NSString *)getString:(NSString *)key
{
    return [items objectForKey:key];
}
   
     
@end
