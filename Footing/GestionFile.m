//
//  GestionFile.m
//  Footing
//
//  Created by admin on 06/05/13.
//  Copyright (c) 2013 Quentin Bontemps. All rights reserved.
//

#import "GestionFile.h"

@implementation GestionFile
@synthesize fileMgr,filepath,homeDir;

-(NSString *)GetDocumentDirectory
{
    fileMgr = [NSFileManager defaultManager];
    homeDir = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    homeDir = [NSString stringWithFormat:@"%@/Cache/",homeDir];
    
    BOOL isDir;
    
    if(![fileMgr fileExistsAtPath:homeDir isDirectory:&isDir]){
        if(![fileMgr createDirectoryAtPath:homeDir withIntermediateDirectories:YES attributes:nil error:nil]){
            NSLog(@"Création dossier intérompu");
        }
    }    
    return homeDir;
}

-(void)writeObject:(NSObject *)myObject filename:(NSString *)filename
{
    filepath = [NSString stringWithFormat:@"%@%@",self.GetDocumentDirectory,filename];
    //filepath = [self.GetDocumentDirectory stringByAppendingPathComponent:filename];
    NSLog(@"filepath : %@",filepath);
    [NSKeyedArchiver archiveRootObject:myObject toFile:filepath];
}

-(NSObject *)readObject:(NSString *)filename
{
    filepath = [NSString stringWithFormat:@"%@%@",self.GetDocumentDirectory,filename];
    //filepath = [self.GetDocumentDirectory stringByAppendingPathComponent:filename];
    NSLog(@"filepath : %@",filepath);
    return [NSKeyedUnarchiver unarchiveObjectWithFile:filepath];
}



@end
