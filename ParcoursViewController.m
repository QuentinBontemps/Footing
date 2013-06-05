//
//  ParcoursViewController.m
//  Footing
//
//  Created by admin on 13/05/13.
//  Copyright (c) 2013 Quentin Bontemps. All rights reserved.
//

#import "ParcoursViewController.h"
#import "MapViewController.h"
#import "ListeTrajetsViewController.h"

@interface ParcoursViewController ()

@end

@implementation ParcoursViewController
@synthesize btnNxParcours,btnListeParcours;

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
    [self.navigationController.navigationBar setTintColor:[Tools getParcoursColor]];
    
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectZero];
    [title setTextColor:[Tools getParcoursFontColor]];
    [title setText:@"Parcours"];
    [title setTextAlignment:NSTextAlignmentCenter];
    [title setBackgroundColor:[UIColor clearColor]];
    [title setFont:[UIFont boldSystemFontOfSize:20]];
    [title sizeToFit];
    
    [self.navigationItem setTitleView:title];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [btnNxParcours setBackgroundColor:[Tools getParcoursColor]];
    [btnListeParcours setBackgroundColor:[Tools getParcoursColor]];
    
    [btnNxParcours.titleLabel setTextColor:[Tools getParcoursFontColor]];
    [btnListeParcours.titleLabel setTextColor:[Tools getParcoursFontColor]];
    
    
    [btnNxParcours.layer setBorderColor:[[UIColor blackColor] CGColor]];
    [btnListeParcours.layer setBorderColor:[[UIColor blackColor] CGColor]];
    
    
    [btnNxParcours.layer setBorderWidth:1];
    [btnListeParcours.layer setBorderWidth:1];
    
    
    [btnNxParcours.layer setCornerRadius:8];
    [btnListeParcours.layer setCornerRadius:8];
    
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"pushToMap"]) {
        MapViewController *destViewController = segue.destinationViewController;
        [destViewController setTypeTrajet:[NSNumber numberWithInt:PARCOURS_STORE]];
    }else if ([segue.identifier isEqualToString:@"pushToTrajets"]){
        ListeTrajetsViewController *destViewController = segue.destinationViewController;
        [destViewController setTypeTrajet:[NSNumber numberWithInt:PARCOURS_STORE]];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
