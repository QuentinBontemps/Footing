//
//  AncienTrajetsViewController.h
//  Footing
//
//  Created by admin on 17/04/13.
//  Copyright (c) 2013 Quentin Bontemps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Trajet.h"
#import "Constant.h"
#import "Cache.h"
#import "Tools.h"
#import "Circuit.h"
#import "Parcours.h"

@interface ListeTrajetsViewController : UITableViewController<UITableViewDataSource,UITableViewDelegate>
{
    NSArray *trajets;
    Cache *cache;
}

@property (strong, nonatomic) NSNumber *typeTrajet;

@end
