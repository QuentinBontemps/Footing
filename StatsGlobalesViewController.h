//
//  StatsGlobalesViewController.h
//  Footing
//
//  Created by admin on 28/05/13.
//  Copyright (c) 2013 Quentin Bontemps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Cache.h"
#import "StatItem.h"

@interface StatsGlobalesViewController : UITableViewController<UITableViewDataSource,UITableViewDelegate>
{
    
    Cache *cache;
    
    NSMutableArray *stats,*statsParcours,*statsCircuits,*statsTotales;
}
@end
