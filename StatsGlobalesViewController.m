//
//  StatsGlobalesViewController.m
//  Footing
//
//  Created by admin on 28/05/13.
//  Copyright (c) 2013 Quentin Bontemps. All rights reserved.
//

#import "StatsGlobalesViewController.h"

@implementation StatsGlobalesViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    cache = [Cache instance];
    
    statsParcours = [[NSMutableArray alloc]init];
    statsCircuits = [[NSMutableArray alloc]init];
    statsTotales = [[NSMutableArray alloc]init];
    
    //Récupération du nombre de trajet de chaque type
    int nbParcoursInt = cache.getParcours.count;
    int nbCircuitsInt = cache.getCircuits.count;
    
    
    //Calcul des distance pour chaque type
    int distanceParcoursInt = 0;
    int distanceCircuitsInt = 0;
    
    NSString *distanceParcours,*distanceCircuits;
    
    for (int i = 0; i < nbParcoursInt; i++) {
        distanceParcoursInt = distanceParcoursInt + [(Parcours *)[cache.getParcours objectAtIndex:i] distance].integerValue;
    }
    
    for (int i = 0; i < nbCircuitsInt; i++) {
        distanceCircuitsInt = distanceCircuitsInt + [(Circuit *)[cache.getCircuits objectAtIndex:i] distance].integerValue;
    }

    if(distanceParcoursInt < 1000){
        distanceParcours = [NSString stringWithFormat:@"%i m",distanceParcoursInt];
    }else{
        distanceParcours = [NSString stringWithFormat:@"%i km, %i m",distanceParcoursInt / 1000, distanceParcoursInt % 1000];
    }
    
    if(distanceCircuitsInt < 1000){
        distanceCircuits = [NSString stringWithFormat:@"%i m",distanceCircuitsInt];
    }else{
        distanceCircuits = [NSString stringWithFormat:@"%i km, %i m",distanceCircuitsInt / 1000, distanceCircuitsInt % 1000];
    }
    
    
    //Calcul du temp pour chaque type
    int tempsParcoursInt = 0;
    int tempsCircuitsInt = 0;
    
    NSString *tempsParcours,*tempsCircuits;
    
    for (int i = 0; i < nbParcoursInt; i++) {
        tempsParcoursInt = tempsParcoursInt + [(Parcours *)[cache.getParcours objectAtIndex:i] tempsTrajet].integerValue;
    }
    
    for (int i = 0; i < nbCircuitsInt; i++) {
        tempsCircuitsInt = tempsCircuitsInt + [(Circuit *)[cache.getCircuits objectAtIndex:i] tempsTrajet].integerValue;
    }
    
    if(tempsParcoursInt < 60){
        tempsParcours = [NSString stringWithFormat:@"%i s",tempsParcoursInt];
    }else if(tempsParcoursInt < 3600){
        tempsParcours = [NSString stringWithFormat:@"%i min %i s",tempsParcoursInt/60,tempsParcoursInt % 60];
    }else{
        tempsParcours = [NSString stringWithFormat:@"%i h %i m %i s",tempsParcoursInt / 3600,(tempsParcoursInt/60)%60,tempsParcoursInt % 60];
    }
    
    if(tempsCircuitsInt < 60){
        tempsCircuits = [NSString stringWithFormat:@"%i s",tempsCircuitsInt];
    }else if(tempsCircuitsInt < 3600){
        tempsCircuits = [NSString stringWithFormat:@"%i min %i s",tempsCircuitsInt/60,tempsCircuitsInt % 60];
    }else{
        tempsCircuits = [NSString stringWithFormat:@"%i h %i m %i s",tempsCircuitsInt / 3600,(tempsCircuitsInt/60)%60,tempsCircuitsInt % 60];
    }
    
    
    //Calcul des infos totales
    int tempsTotalInt = tempsParcoursInt + tempsCircuitsInt;
    int distanceTotalInt = distanceParcoursInt + distanceCircuitsInt;
    
    NSString *tempsTotal,*distanceTotal;
    
    if(distanceTotalInt < 1000){
        distanceTotal = [NSString stringWithFormat:@"%i m",distanceTotalInt];
    }else{
        distanceTotal = [NSString stringWithFormat:@"%i km, %i m",distanceTotalInt / 1000, distanceTotalInt % 1000];
    }
    
    if(tempsTotalInt < 60){
        tempsTotal = [NSString stringWithFormat:@"%i s",tempsTotalInt];
    }else if(tempsTotalInt < 3600){
        tempsTotal = [NSString stringWithFormat:@"%i min %i s",tempsTotalInt/60,tempsTotalInt % 60];
    }else{
        tempsTotal = [NSString stringWithFormat:@"%i h %i m %i s",tempsTotalInt / 3600,(tempsTotalInt/60)%60,tempsTotalInt % 60];
    }
    
    
    //Création des items parcours
    StatItem *nbParcoursItem = [[StatItem alloc]initWithTitle:@"Parcours enregistrés" andDetail:[NSString stringWithFormat:@"%i",nbParcoursInt]];
    
    StatItem *distanceParcoursItem = [[StatItem alloc]initWithTitle:@"Distance " andDetail:distanceParcours];
    
    StatItem *tempsParcoursItem = [[StatItem alloc]initWithTitle:@"Temps" andDetail:tempsParcours];
    
    //Création des items circuits
    StatItem *nbCircuitsItem = [[StatItem alloc]initWithTitle:@"Circuits enregistrés" andDetail:[NSString stringWithFormat:@"%i",nbCircuitsInt]];
    
    StatItem *distanceCircuitsItem = [[StatItem alloc]initWithTitle:@"Distance " andDetail:distanceCircuits];
    
    StatItem *tempsCircuitsItem = [[StatItem alloc]initWithTitle:@"Temps" andDetail:tempsCircuits];
    
    //Création des items Total
    StatItem *distanceTotalItem = [[StatItem alloc]initWithTitle:@"Distance" andDetail:distanceTotal];
    StatItem *tempsTotalItem = [[StatItem alloc]initWithTitle:@"Temps" andDetail:tempsTotal];
    
    //Ajout dans les différents tableaux
    [statsParcours addObject:nbParcoursItem];
    [statsParcours addObject:distanceParcoursItem];
    [statsParcours addObject:tempsParcoursItem];
    
    [statsCircuits addObject:nbCircuitsItem];
    [statsCircuits addObject:distanceCircuitsItem];
    [statsCircuits addObject:tempsCircuitsItem];
    
    
    [statsTotales addObject:distanceTotalItem];
    [statsTotales addObject:tempsTotalItem];
    
    stats = [[NSMutableArray alloc]initWithObjects:statsParcours,statsCircuits,statsTotales, nil];
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
    return stats.count;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *title;
    switch (section) {
        case 0:
            title = @"Parcours";
            break;
        case 1:
            title = @"Circuits";
            break;
        case 2:
            title = @"Total";
            break;
        default:
            break;
    }
    return title;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int nbRows = 0;
    switch (section) {
        case 0:
            nbRows = statsParcours.count;
        case 1:
            nbRows = statsCircuits.count;
            break;
        case 2:
            nbRows = statsTotales.count;
            break;
        default:
            break;
    }
    return  nbRows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    UITableViewCell *cell =  [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    NSArray *array = [stats objectAtIndex:indexPath.section];
    StatItem *item = (StatItem *)[array objectAtIndex:indexPath.row];
    
    
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
