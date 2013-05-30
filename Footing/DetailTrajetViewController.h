//
//  DetailTrajetViewController.h
//  Footing
//
//  Created by admin on 30/05/13.
//  Copyright (c) 2013 Quentin Bontemps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Trajet.h"
#import "StatItem.h"
#import "Parcours.h"
#import "Circuit.h"
#import "Tools.h"

@interface DetailTrajetViewController : UITableViewController
{
    NSMutableArray *infosTrajet;
}
@property (nonatomic,strong)Trajet *trajet;

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil trajet:(Trajet *)pTrajet;
@end
