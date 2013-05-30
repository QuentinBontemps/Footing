//
//  ListeAncienTrajetsViewController.m
//  Footing
//
//  Created by admin on 27/05/13.
//  Copyright (c) 2013 Quentin Bontemps. All rights reserved.
//

#import "ListeAncienTrajetsViewController.h"
#import "ListeTrajetsViewController.h"

@interface ListeAncienTrajetsViewController ()

@end

@implementation ListeAncienTrajetsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    ListeTrajetsViewController *l1 = [self.viewControllers objectAtIndex:0];
    [l1 setTypeTrajet:[NSNumber numberWithInt:PARCOURS_STORE]];
    
   
    ListeTrajetsViewController *l2 = [self.viewControllers objectAtIndex:1];
    [l2 setTypeTrajet:[NSNumber numberWithInt:CIRCUITS_STORE]];
 }


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
