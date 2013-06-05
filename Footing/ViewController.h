//
//  ViewController.h
//  Footing
//
//  Created by admin on 17/04/13.
//  Copyright (c) 2013 Quentin Bontemps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "Cache.h"
#import "AppDelegate.h"
#import "ListeTrajetsViewController.h"
#import "Constant.h"
#import "Tools.h"

@interface ViewController : UIViewController
{
    Configuration *configuration;
    Cache *cache;
}

@property (nonatomic, strong) IBOutlet UIButton *btnParcours;
@property (nonatomic, strong) IBOutlet UIButton *btnCircuits;
@property (nonatomic, strong) IBOutlet UIButton *btnAnciensParcours;
@property (nonatomic, strong) IBOutlet UIButton *btnStats;


@end
