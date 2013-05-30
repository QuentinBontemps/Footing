//
//  GestionFile.h
//  Footing
//
//  Created by admin on 06/05/13.
//  Copyright (c) 2013 Quentin Bontemps. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GestionFile : NSObject

@property(nonatomic,retain) NSFileManager *fileMgr;
@property(nonatomic,retain) NSString *homeDir;
@property(nonatomic,retain) NSString *filepath;

-(NSString *) GetDocumentDirectory;

-(void)writeObject:(NSObject *)myObject filename:(NSString *)filename;
-(NSObject *)readObject:(NSString *)filename;

@end
