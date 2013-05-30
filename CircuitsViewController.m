//
//  CircuitsViewController.m
//  Footing
//
//  Created by admin on 13/05/13.
//  Copyright (c) 2013 Quentin Bontemps. All rights reserved.
//

#import "CircuitsViewController.h"

@interface CircuitsViewController ()

@end

@implementation CircuitsViewController

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
