//
//  Configuration.h
//  Footing
//
//  Created by admin on 06/05/13.
//  Copyright (c) 2013 Quentin Bontemps. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Configuration : NSObject
{
    NSMutableDictionary *items;
}

+(Configuration *)instance;

-(void)start;
-(void)put:(NSString *)key item:(NSObject *)item;
-(NSObject *)get:(NSString *)key;
-(int)getInt:(NSString *)key;
-(NSNumber *)getDouble:(NSString *)key;
-(float)getFloat:(NSString *)key;
-(NSString *)getString:(NSString *)key;
-(BOOL)getBoolean:(NSString *)key;


@end
