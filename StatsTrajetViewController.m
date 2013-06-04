//
//  StatsTrajetViewController.m
//  Footing
//
//  Created by admin on 29/05/13.
//  Copyright (c) 2013 Quentin Bontemps. All rights reserved.
//

#import "StatsTrajetViewController.h"
#import "DetailTrajetViewController.h"
#import "MapViewController.h"

@implementation StatsTrajetViewController
@synthesize trajet, isDetails;

- (void)viewDidLoad
{
    [super viewDidLoad];

    infosGlobalesTrajet = [[NSMutableArray alloc]init];
    
    cache = [Cache instance];
    
    StatItem *nom = [[StatItem alloc]initWithTitle:@"Nom" andDetail:trajet.nom];
    StatItem *nbEffectue = [[StatItem alloc]initWithTitle:@"Nombre de fois réalisé" andDetail:[NSString stringWithFormat:@"%i",trajet.trajets.count + 1]];
    
    [infosGlobalesTrajet addObject:nom];
    [infosGlobalesTrajet addObject:nbEffectue];
    
    if([trajet isKindOfClass:[Parcours class]]){
        StatItem *distance = [[StatItem alloc]initWithTitle:@"Distance" andDetail:[Tools meterToString:trajet.distance.integerValue]];
        
        int meilleurTempsInt = trajet.tempsTrajet.integerValue;
        
        if([trajet isKindOfClass:[Parcours class]]){
            for (Parcours *parcours in trajet.trajets) {
                if (parcours.tempsTrajet.integerValue < meilleurTempsInt) {
                    meilleurTempsInt = parcours.tempsTrajet.integerValue;
                }
            }
        }
        
        StatItem *meilleurTemps = [[StatItem alloc]initWithTitle:@"Meilleur temps" andDetail:[Tools secondToString:meilleurTempsInt]];
        
        int dernierTempsInt = trajet.tempsTrajet.integerValue;
        
        if(trajet.trajets.count >= 1){
            dernierTempsInt = [[(Trajet *)[trajet.trajets objectAtIndex:trajet.trajets.count -1] tempsTrajet]integerValue];
        }
        
        StatItem *dernierTemps = [[StatItem alloc]initWithTitle:@"Dernier temps" andDetail:[Tools secondToString:dernierTempsInt]];
        
        [infosGlobalesTrajet addObject:distance];
        [infosGlobalesTrajet addObject:meilleurTemps];
        [infosGlobalesTrajet addObject:dernierTemps];
    }else if([trajet isKindOfClass:[Circuit class]]){
        
        Circuit *trajetCircuit = (Circuit *)trajet;
        
        int nbToursTotalInt = ((Circuit *)trajet).tempsTour.count;
        
        for (Circuit *circuit in trajet.trajets) {
            nbToursTotalInt = nbToursTotalInt + circuit.tempsTour.count;
        }
        
        StatItem *nbToursTotal = [[StatItem alloc]initWithTitle:@"Nombre de tours total" andDetail:[NSString stringWithFormat:@"%i",nbToursTotalInt]];
        
        
        int meilleurTempsToursInt = [[trajetCircuit.tempsTour objectAtIndex:0] integerValue];
        
        for (int i = 0; i < trajetCircuit.tempsTour.count; i++) {
            if([[trajetCircuit.tempsTour objectAtIndex:i] integerValue] < meilleurTempsToursInt){
                meilleurTempsToursInt = [[trajetCircuit.tempsTour objectAtIndex:i] integerValue];
            }
        }
        
        for (Circuit *circuit in trajetCircuit.trajets) {
            for (int i = 0; i < circuit.tempsTour.count; i++) {
                if([[circuit.tempsTour objectAtIndex:i] integerValue] < meilleurTempsToursInt){
                    meilleurTempsToursInt = [[circuit.tempsTour objectAtIndex:i] integerValue];
                }
            }
        }
        
        StatItem *meilleurTempsTours = [[StatItem alloc]initWithTitle:@"Meilleur tour" andDetail:[Tools secondToString:meilleurTempsToursInt]];
        
        
        
        
        
        
        [infosGlobalesTrajet addObject:nbToursTotal];
        [infosGlobalesTrajet addObject:meilleurTempsTours];
    }
    
    trajets = [[NSMutableArray alloc]init];
    [trajets addObject:trajet];
    [trajets addObjectsFromArray:trajet.trajets];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
       return [infosGlobalesTrajet count];
    }else if(section == 2){
        return trajets.count;
    }
    return 1;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return @"Informations globales";
    }else if(section == 1){
        return @"Map";
    }else if (section == 2){
        return @"Tous les trajets réalisés";
    }
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell;
    if(indexPath.section == 0){
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        cell.textLabel.text = [(StatItem *)[infosGlobalesTrajet objectAtIndex:indexPath.row] title];
        cell.detailTextLabel.text = [(StatItem *)[infosGlobalesTrajet objectAtIndex:indexPath.row] detail];
        cell.userInteractionEnabled = NO;
    }else if(indexPath.section == 1){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell2"];
        cell.textLabel.text = @"Voir le trajet sur la carte";
        cell.textLabel.font = []
        cell.userInteractionEnabled = YES;
        cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    }else if(indexPath.section == 2){
        Trajet *t = (Trajet *) [trajets objectAtIndex:indexPath.row];
        
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell3"];
        
        cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
        cell.textLabel.text = [Tools dateToFullString:t.dateTrajet];
        cell.detailTextLabel.text = [Tools meterToString:t.distance.integerValue];
        cell.userInteractionEnabled = YES;
    }
           
    return cell;
}




// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 2 && indexPath.row == 0){
        return NO;
    }else if(indexPath.section == 1){
        return NO;
    }else{
        return YES;
    }
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [trajets removeObjectAtIndex:indexPath.row];
        [cache removeTrajet:trajet removeTrajet:[trajet.trajets objectAtIndex:indexPath.row -1 ]];
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
    
    if(indexPath.section == 1){        
        [self performSegueWithIdentifier:@"pushToMap" sender:nil];
    }else if (indexPath.section == 2){
        DetailTrajetViewController *detailViewController = [[DetailTrajetViewController alloc]initWithNibName:@"DetailTrajetViewController" bundle:nil ];
        
        [detailViewController setTrajet:(Trajet *)[trajets objectAtIndex:indexPath.row]];
        
        
        [self.navigationController pushViewController:detailViewController animated:YES];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"pushToMap"]){
        NSLog(@"mok");
        MapViewController* destViewController = segue.destinationViewController;
        [destViewController setOldTrajet:trajet];
        [destViewController setTypeTrajet:[NSNumber numberWithInt:ANCIEN_PARCOURS]];
    }
}

@end
