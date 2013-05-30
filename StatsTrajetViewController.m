//
//  StatsTrajetViewController.m
//  Footing
//
//  Created by admin on 29/05/13.
//  Copyright (c) 2013 Quentin Bontemps. All rights reserved.
//

#import "StatsTrajetViewController.h"
#import "DetailTrajetViewController.h"

@implementation StatsTrajetViewController
@synthesize trajet;

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
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
       return [infosGlobalesTrajet count];
    }else{
        return trajets.count;
    }
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return @"Informations globales";
    }else{
        return @"Tous les trajets réalisés";
    }
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
    }else{
        Trajet *t = (Trajet *) [trajets objectAtIndex:indexPath.row];
        
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell2"];
        
        cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
        cell.textLabel.text = [Tools dateToFullString:t.dateTrajet];
        cell.detailTextLabel.text = [Tools meterToString:t.distance.integerValue];
        cell.userInteractionEnabled = YES;
    }
           
    return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"%@",segue.identifier);
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 1 && indexPath.row == 0){
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
    
    
    DetailTrajetViewController *detailViewController = [[DetailTrajetViewController alloc]initWithNibName:@"DetailTrajetViewController" bundle:nil ];
    
    [detailViewController setTrajet:(Trajet *)[trajets objectAtIndex:indexPath.row]];
    
    
    [self.navigationController pushViewController:detailViewController animated:YES];
     

    
}

@end
