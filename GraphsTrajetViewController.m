//
//  GraphsTrajetViewController.m
//  Footing
//
//  Created by admin on 29/05/13.
//  Copyright (c) 2013 Quentin Bontemps. All rights reserved.
//

#import "GraphsTrajetViewController.h"

@implementation GraphsTrajetViewController
@synthesize trajet;

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    NSMutableArray *allTrajets = [[NSMutableArray alloc]initWithObjects:trajet, trajet.trajets, nil];
   
    for (int i = 0; i < trajet.getTrajetsNumber; i++) {
        UIView *trajetView = [[UIView alloc]initWithFrame:CGRectMake(10*i, 10*i, 20, 20)];
        
        UIView *point = [[UIView alloc]initWithFrame:CGRectMake(5, 5, 5, 5)];
        [point setBackgroundColor:[UIColor redColor]];
        
        [trajetView addSubview:point];
        
        [self.view addSubview:trajetView];
        
     }
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 200, self.view.bounds.size.width, 1)];
    lineView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:lineView];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
