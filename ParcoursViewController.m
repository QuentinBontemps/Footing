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

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
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
