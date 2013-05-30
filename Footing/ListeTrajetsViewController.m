//
//  AncienTrajetsViewController.m
//  Footing
//
//  Created by admin on 17/04/13.
//  Copyright (c) 2013 Quentin Bontemps. All rights reserved.
//

#import "ListeTrajetsViewController.h"
#import "DetailTrajetViewController.h"
#import "MapViewController.h"
#import "StatsTrajetViewController.h"

@interface ListeTrajetsViewController ()

@end

@implementation ListeTrajetsViewController

@synthesize typeTrajet;


- (void)viewDidLoad
{
    [super viewDidLoad];

    trajets = [[NSArray alloc]init];
    cache = [Cache instance];    
    
    switch (typeTrajet.intValue) {
        case CIRCUITS_STORE:
            trajets = [cache getCircuits];
            break;
            
        case PARCOURS_STORE:
            trajets = [cache getParcours];
            break;
            
        default:
            trajets = [cache getCircuits];
            trajets = [trajets arrayByAddingObjectsFromArray:[cache getParcours]];
            break;
    }
    
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
    return [trajets count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"TrajetCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier ];
    
    // Configure the cell...
    
    if(cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellIdentifier];
        [cell setAccessoryType:UITableViewCellAccessoryDetailDisclosureButton];
    }
    
    Trajet *trajet = [trajets objectAtIndex:indexPath.row];
    
    if(typeTrajet.integerValue == ANCIEN_PARCOURS){
        if([trajet isKindOfClass:[Circuit class]]){
            [cell.textLabel setText:[NSString stringWithFormat:@"C - %@",[trajet nom]]];
        }else if([trajet isKindOfClass:[Parcours class]]){
            [cell.textLabel setText:[NSString stringWithFormat:@"P - %@",[trajet nom]]];
        }
    }else{
        [cell.textLabel setText:[trajet nom]];
    }
    
    
    [cell.detailTextLabel setText: [Tools distanceToString:[trajet distance]]];
    return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"pushToMap"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        MapViewController* destViewController = segue.destinationViewController;
        [destViewController setOldTrajet:[trajets objectAtIndex:indexPath.row]];
        [destViewController setTypeTrajet:[NSNumber numberWithInt:ANCIEN_PARCOURS]];
    }else if ([segue.identifier isEqualToString:@"pushToDetailTrajet"]){
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        DetailTrajetViewController* destViewController = segue.destinationViewController;
        [destViewController setTrajet:[trajets objectAtIndex:indexPath.row]];
    }else if ([segue.identifier isEqualToString:@"pushToStats"]){
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        StatsTrajetViewController* destViewController = segue.destinationViewController;
        [destViewController setTrajet:[trajets objectAtIndex:indexPath.row]];
    }
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [cache removeTrajet:[trajets objectAtIndex:indexPath.row]];
        [tableView reloadData];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


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
