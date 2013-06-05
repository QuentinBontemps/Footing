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
@synthesize btnParcours,btnCircuits,btnAnciensParcours,btnStats;

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setTintColor:[Tools getAccueilColor]];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    configuration = [Configuration instance];
    cache = [Cache instance];
    
    NSInvocationOperation *operation = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(configureApp) object:nil];
    
    [[[AppDelegate new] queue]addOperation:operation];
    
    [btnParcours setBackgroundColor:[Tools getParcoursColor]];
    [btnCircuits setBackgroundColor:[Tools getCircuitsColor]];
    [btnAnciensParcours setBackgroundColor:[Tools getAnciensParcoursColor]];
    [btnStats setBackgroundColor:[Tools getStatsColor]];
    
    [btnParcours.titleLabel setTextColor:[Tools getParcoursFontColor]];
    [btnCircuits.titleLabel setTextColor:[Tools getCircuitsFontColor]];
    [btnAnciensParcours.titleLabel setTextColor:[Tools getAnciensParcoursFontColor]];
    [btnStats.titleLabel setTextColor:[Tools getStatsFontColor]];
    
    [btnParcours.layer setBorderColor:[[UIColor blackColor] CGColor]];
    [btnCircuits.layer setBorderColor:[[UIColor blackColor] CGColor]];
    [btnAnciensParcours.layer setBorderColor:[[UIColor blackColor] CGColor]];
    [btnStats.layer setBorderColor:[[UIColor blackColor] CGColor]];
    
    [btnParcours.layer setBorderWidth:1];
    [btnCircuits.layer setBorderWidth:1];
    [btnAnciensParcours.layer setBorderWidth:1];
    [btnStats.layer setBorderWidth:1];
    
    [btnParcours.layer setCornerRadius:8];
    [btnCircuits.layer setCornerRadius:8];
    [btnAnciensParcours.layer setCornerRadius:8];
    [btnStats.layer setCornerRadius:8];
    
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
