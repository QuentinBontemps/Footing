//
//  StatsTrajetViewController.h
//  Footing
//
//  Created by admin on 29/05/13.
//  Copyright (c) 2013 Quentin Bontemps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Trajet.h"
#import "StatItem.h"
#import "Parcours.h"
#import "Circuit.h"
#import "Tools.h"
#import "Cache.h"
#import "Constant.h"

@interface StatsTrajetViewController : UITableViewController
{
    NSMutableArray *infosGlobalesTrajet, *trajets;
    
    Cache *cache;
}

@property (nonatomic, strong) Trajet *trajet;
@property (nonatomic, strong) NSNumber *isDetails;

@end
