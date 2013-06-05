//
//  StatsTrajetTabViewController.m
//  Footing
//
//  Created by admin on 29/05/13.
//  Copyright (c) 2013 Quentin Bontemps. All rights reserved.
//

#import "StatsTrajetTabViewController.h"
#import "StatsTrajetViewController.h"
#import "GraphsTrajetViewController.h"

@interface StatsTrajetTabViewController ()

@end

@implementation StatsTrajetTabViewController
@synthesize trajet;

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
	
    StatsTrajetViewController *view = (StatsTrajetViewController *)[self.viewControllers objectAtIndex:0];
    [view setTrajet:trajet];
    
    GraphsTrajetViewController *view2 = (GraphsTrajetViewController *)[self.viewControllers objectAtIndex:1];
    [view2 setTrajet:trajet];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
