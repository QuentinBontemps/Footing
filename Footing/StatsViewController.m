//
//  StatsViewController.m
//  Footing
//
//  Created by admin on 05/06/13.
//  Copyright (c) 2013 Quentin Bontemps. All rights reserved.
//

#import "StatsViewController.h"
#import "ListeAncienTrajetsViewController.h"


@implementation StatsViewController
@synthesize btnTrajet,btnGlobales;

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
    [self.navigationController.navigationBar setTintColor:[Tools getStatsColor]];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [btnTrajet setBackgroundColor:[Tools getStatsColor]];
    [btnGlobales setBackgroundColor:[Tools getStatsColor]];
        
    [btnTrajet.titleLabel setTextColor:[Tools getStatsFontColor]];
    [btnGlobales.titleLabel setTextColor:[Tools getStatsFontColor]];
        
    [btnTrajet.layer setBorderColor:[[UIColor blackColor] CGColor]];
    [btnGlobales.layer setBorderColor:[[UIColor blackColor] CGColor]];
    
    [btnTrajet.layer setBorderWidth:1];
    [btnGlobales.layer setBorderWidth:1];
    
    [btnTrajet.layer setCornerRadius:8];
    [btnGlobales.layer setCornerRadius:8];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"pushToTrajets"]){
        ListeAncienTrajetsViewController *destViewController = segue.destinationViewController;
        [destViewController setIsStats:[NSNumber numberWithBool:YES]];
    }
}

@end
