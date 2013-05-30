//
//  ViewController.m
//  Footing
//
//  Created by admin on 17/04/13.
//  Copyright (c) 2013 Quentin Bontemps. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    configuration = [Configuration instance];
    cache = [Cache instance];
    
    NSInvocationOperation *operation = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(configureApp) object:nil];
    
    [[[AppDelegate new] queue]addOperation:operation];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) configureApp
{
    [configuration start];
    [cache start];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"pushToAncienTrajets"]){
        ListeTrajetsViewController *destViewController = segue.destinationViewController;
        [destViewController setTypeTrajet:[NSNumber numberWithInt:ANCIEN_PARCOURS]];
    }
}

@end
