//
//  DetailTrajetViewController.m
//  Footing
//
//  Created by admin on 30/05/13.
//  Copyright (c) 2013 Quentin Bontemps. All rights reserved.
//

#import "DetailTrajetViewController.h"

@implementation DetailTrajetViewController
@synthesize trajet;

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil trajet:(Trajet *)pTrajet
{
    if(self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]){
        pTrajet = trajet;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    infosTrajet = [[NSMutableArray alloc]init];
        StatItem *date = [[StatItem alloc]initWithTitle:@"Date" andDetail:[Tools dateToFullString:trajet.dateTrajet]];
    StatItem *distance = [[StatItem alloc]initWithTitle:@"Distance" andDetail:[Tools distanceToString:trajet.distance]];
    StatItem *temps = [[StatItem alloc]initWithTitle:@"Temps" andDetail:[Tools secondToString:trajet.tempsTrajet.integerValue]];
    
    
    [infosTrajet addObject:date];
    [infosTrajet addObject:distance];
    [infosTrajet addObject:temps];
    
    if([trajet isKindOfClass:[Circuit class]]){
        
        StatItem *nbTours = [[StatItem alloc]initWithTitle:@"Nombre de tours" andDetail:[NSString stringWithFormat:@"%i",((Circuit *)trajet).tempsTour.count]];
        
        
        int tempsToursInt = 0;
        NSLog(@"nbTours : %i",((Circuit *)trajet).tempsTour.count);
        for (NSNumber *tempsTours in ((Circuit *)trajet).tempsTour) {
            NSLog(@"tempsTours : %i",tempsTours.integerValue);
            tempsToursInt = tempsToursInt + tempsTours.integerValue;
        }
        
        int moyenneToursInt = tempsToursInt /  ((Circuit *)trajet).tempsTour.count;
        
        StatItem *moyenneInt = [[StatItem alloc]initWithTitle:@"Moyenne par tours" andDetail:[Tools secondToString:moyenneToursInt]];
        
        [infosTrajet addObject:nbTours];
        [infosTrajet addObject:moyenneInt];        
    }else if([trajet isKindOfClass:[Parcours class]]){
               
        
        
    }
    
    float distanceKm = trajet.distance.floatValue / 1000;
    float tempsHeure = trajet.tempsTrajet.floatValue / 3600;
    
    float vitesseMoyenne = distanceKm / tempsHeure;
    
    
    
    StatItem *vitesseMoyenneItem = [[StatItem alloc]initWithTitle:@"Vitesse moyenne" andDetail:[NSString stringWithFormat:@"%.02f KM/H",vitesseMoyenne]];
    
    [infosTrajet addObject:vitesseMoyenneItem];
    
    
    NSLog(@"nbInfos : %i",infosTrajet.count);

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [infosTrajet count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"Cell"];
    
    [cell setUserInteractionEnabled:NO];
    
    StatItem *item = (StatItem *)[infosTrajet objectAtIndex:indexPath.row];
    
    cell.textLabel.text = item.title;
    cell.detailTextLabel.text = item.detail;
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/
/*

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/
/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
