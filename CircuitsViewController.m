//
//  CircuitsViewController.m
//  Footing
//
//  Created by admin on 13/05/13.
//  Copyright (c) 2013 Quentin Bontemps. All rights reserved.
//

#import "CircuitsViewController.h"

@implementation CircuitsViewController
@synthesize btnNxCircuit,btnListeCircuits;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setTintColor:[Tools getCircuitsColor]];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [btnNxCircuit setBackgroundColor:[Tools getCircuitsColor]];
    [btnListeCircuits setBackgroundColor:[Tools getCircuitsColor]];
    
    [btnNxCircuit.titleLabel setTextColor:[Tools getCircuitsFontColor]];
    [btnListeCircuits.titleLabel setTextColor:[Tools getCircuitsFontColor]];
    
    
    [btnNxCircuit.layer setBorderColor:[[UIColor blackColor] CGColor]];
    [btnListeCircuits.layer setBorderColor:[[UIColor blackColor] CGColor]];
    
    
    [btnNxCircuit.layer setBorderWidth:1];
    [btnListeCircuits.layer setBorderWidth:1];
    
    
    [btnNxCircuit.layer setCornerRadius:8];
    [btnListeCircuits.layer setCornerRadius:8];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"pushToMap"]) {
        NSLog(@"pushToMap");
        MapViewController *destViewController = segue.destinationViewController;
        [destViewController setTypeTrajet:[NSNumber numberWithInt:2]];
    }else if ([segue.identifier isEqualToString:@"pushToTrajets"]){
        NSLog(@"pushToTrajets");
        ListeTrajetsViewController *destViewController = segue.destinationViewController;
        [destViewController setTypeTrajet:[NSNumber numberWithInt:2]];
    }
}
@end
