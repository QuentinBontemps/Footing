//
//  MapViewController.m
//  Footing
//
//  Created by admin on 18/04/13.
//  Copyright (c) 2013 Quentin Bontemps. All rights reserved.
//

#import "MapViewController.h"


@implementation MapViewController
@synthesize typeTrajet,mapView,trajet,oldTrajet,btnStartStop,btnPause,lblTempsEcoule,lblDistance;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
   
    cache = [Cache instance];
    
    NSLog(@"typeTrajet : %i",typeTrajet.integerValue);
	   
    btnState = true;
    pauseTrajet = false;
    getCircuitCheckpoint = true;
    nbCheckpoints = 0;
    nbCheckpointsOk = 0;
    tempsTours = 0;
    
    [btnPause setEnabled:NO];
    
    [self configureMap];
    
    //Suppression de tous les composants ajouté sur la carte
    [self.mapView removeOverlays:self.mapView.overlays];
    
    //Si on arrive depuis la liste des anciens trajets
    if(typeTrajet.integerValue == ANCIEN_PARCOURS){
        //Tracage du trajet déjà réalisé
        [self tracerTrajet:oldTrajet];
        
        //Affichage des différents checkpoints
        for (MapPin *checkpoint in [oldTrajet checkpoints]) {
            [self.mapView addAnnotation:checkpoint];
        }
    }else if(typeTrajet.integerValue == CIRCUITS_STORE){
        [self showNbTours];
    }
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id<MKOverlay>)overlay
{
    Polyline *polyline = overlay;
    
    MKPolylineView *polylineView = [[MKPolylineView alloc]initWithPolyline:polyline];
    
    polylineView.fillColor = polyline.color;
    polylineView.strokeColor = polyline.color;
    polylineView.lineWidth = 4;
    
    return polylineView;

}

-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    return nil;
}

-(void)mapView:(MKMapView *)aMapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    
    MKCoordinateRegion region;
    MKCoordinateSpan span;
    span.latitudeDelta = 0.002;
    span.longitudeDelta = 0.002;
    CLLocationCoordinate2D location;
    
    //Si affichage trajet déjà réalisé et que le nouveau toujours pas commencé
    //Carte centré sur le trajet
    if(typeTrajet.integerValue == ANCIEN_PARCOURS && trajet == nil){
        location.latitude = [(MapPin *)[oldTrajet.checkpoints objectAtIndex:0]coordinate].latitude;
        location.longitude  =  [(MapPin *)[oldTrajet.checkpoints objectAtIndex:0]coordinate].longitude;
    }
    //Sinon carte centré sur l'utilisateur
    else{
        location.latitude = userLocation.coordinate.latitude;
        location.longitude = userLocation.coordinate.longitude;
    }
        
    region.span = span;
    region.center = location;
    [mapView setRegion:region animated:YES];
    
    
    if(trajet != nil && trajet.isUpdatable.boolValue && !pauseTrajet){
        CLLocationCoordinate2D coordinate = userLocation.location.coordinate;
    
        Etape *etape = [[Etape alloc]initWithLatitude:[NSNumber numberWithDouble:coordinate.latitude] longitude:[NSNumber numberWithDouble:coordinate.longitude]];
                
        [[trajet trajetReel]addObject:etape];
        NSLog(@"nbEtapes : %i",trajet.trajetReel.count);
        
        //Suppression de tous les composants ajouté sur la carte
        [self.mapView removeOverlays:self.mapView.overlays];
        //Si ancien trajet, on le trace
        if(oldTrajet != nil){
            [self tracerTrajet:oldTrajet];
        }
        //Tracage du trajet en cours
        [self tracerTrajet:trajet];
        
        //Si on est sur un nouveau trajet
        //On ajoute des checkpoints tous les 100m
        if(typeTrajet.integerValue != ANCIEN_PARCOURS){
            //Si la distance parcours depuis le dernier checkpoint
            //est égale ou supérieur à 100 on ajoute un checkpoint
            if([trajet isKindOfClass:[Parcours class]]){
                if([self calculDistance:trajet.trajetReel].integerValue >= (100 * nbCheckpoints)){
                    MapPin *checkpoint = [[MapPin alloc]initWithCoordinates:coordinate placeName:[NSString stringWithFormat:@"Checkpoint %i",nbCheckpoints] description:@""];
                                
                    [[trajet checkpoints]addObject:checkpoint];
                    nbCheckpoints++;
                
                    NSLog(@"addCheckpoint");
                }
            }else if ([trajet isKindOfClass:[Circuit class]]){
                if([self calculDistance:trajet.trajetReel].integerValue >= (100 * nbCheckpoints) && getCircuitCheckpoint){
                    MapPin *checkpoint = [[MapPin alloc]initWithCoordinates:coordinate placeName:[NSString stringWithFormat:@"Checkpoint %i",nbCheckpoints] description:@""];
                            
                    [[trajet checkpoints]addObject:checkpoint];
                    nbCheckpoints++;
                            
                    NSLog(@"addCheckpoint");
                }
            }
        }
        //Sinon on test que l'utilisateur passe bien aux alentours
        //des différents checkpoints établie lors de la création du trajet
        else{
            if (oldTrajet != nil) {
                if(nbCheckpointsOk < oldTrajet.checkpoints.count){
                   //NSLog(@"distance : %f",[userLocation.location distanceFromLocation:[(MapPin *)[oldTrajet.checkpoints objectAtIndex:nbCheckpointsOk] location]]);
    
                    MapPin *checkpointTemp = (MapPin *)[oldTrajet.checkpoints objectAtIndex:nbCheckpointsOk];
                    
                    if([self calculDistance:trajet.trajetReel].integerValue >= (100 * nbCheckpointsOk) && [self calculDistance:trajet.trajetReel].integerValue < ((100 * nbCheckpointsOk) + 100) && !checkpointTemp.isDepart.boolValue && !checkpointTemp.isArrivee.boolValue){
                        
                        if([userLocation.location distanceFromLocation:[checkpointTemp location]] <= 10){
                            NSLog(@"checkpoint %i OK",nbCheckpointsOk);
                            nbCheckpointsOk++;
                        }else{
                            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Attention !" message:@"Vous n'êtes pas passé par un checkpoint" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                            [alert show];
                        }
                    }else if(checkpointTemp.isDepart.boolValue && [checkpointTemp.location distanceFromLocation:userLocation.location] <= 10){
                        NSLog(@"checkpoint Depart %i OK",nbCheckpointsOk);
                        nbCheckpointsOk++;
                    }else if (checkpointTemp.isArrivee.boolValue && [checkpointTemp.location distanceFromLocation:userLocation.location] <= 10){
                        NSLog(@"checkpoint Arrivée %i OK",nbCheckpointsOk);
                        nbCheckpointsOk++;
                    }
                }
            }
        }
        //Si c'est un circuit,
        //on vérifie s'il passe à côté du pt de départ pour mettre à jour le tableau des temps par tour
        if([trajet isKindOfClass:[Circuit class]]){
            if([userLocation.location distanceFromLocation:trajet.depart.getLocation] <= 5 ){
                if (getTours) {
                    NSLog(@"TempsTours : %i",tempsTours);
                    [((Circuit *)trajet).tempsTour addObject:[NSNumber numberWithInt:tempsTours]];
                    tempsTours = 0;
                    
                    [self showNbTours];
                    
                    getTours = false;
                }
                                
               
                if(((Circuit *)trajet).tempsTour.count > 0 && getCheckpointTours){
                    getCircuitCheckpoint = false;
                    getCheckpointTours = false;
                }
            }else if([userLocation.location distanceFromLocation:trajet.depart.getLocation] > 5){
                getTours = true;
                getCheckpointTours = true;
            }
        }
    }
}


-(void)btnStartStopOnClick:(id)sender
{    
    if(btnState){
        if(!pauseTrajet){
            [self createTrajet];
        }else{
            [self pauseTrajet];
        }
       
    }else{
        [self stopTrajet];
    }
 }

-(void)btnPauseOnClick:(id)sender
{
    NSLog(@"Pause Trajet");
    
    [self pauseTrajet];
}


-(void)configureMap
{
    //Initialisation de la carte
    [mapView setMapType:MKMapTypeStandard];
    [mapView setZoomEnabled:YES];
    [mapView setScrollEnabled:YES];
    
    MKCoordinateRegion regionMap;
    
    regionMap.span.latitudeDelta = 0.01f;
    regionMap.span.longitudeDelta = 0.01f;
    
    if(oldTrajet != nil){
        regionMap.center.latitude = [(MapPin *)[oldTrajet.checkpoints objectAtIndex:0]coordinate].latitude;
        regionMap.center.longitude  =  [(MapPin *)[oldTrajet.checkpoints objectAtIndex:0]coordinate].longitude;
    }else{
        regionMap.center.latitude = 48.077863;
        regionMap.center.longitude = -0.7701379999999745;
    }
    
    [mapView setRegion:regionMap animated:YES];

    //Initialisation du delegate
    locationManager = [[CLLocationManager alloc] init];
    [locationManager setDelegate:self];
    //La meilleure localisation possible
    [locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    //L'utilisateur doit faire 2 mètres avant que la position de la carte s'actualise
    [locationManager setDistanceFilter:2.0f];
    
    [locationManager setHeadingFilter:1];
    
    [locationManager startUpdatingLocation];
    [locationManager startUpdatingHeading];
    [mapView setShowsUserLocation:YES];

}

-(void)createTrajet
{
    NSLog(@"CreateTrajet");
    
    BOOL isOk = true;
    
    if(oldTrajet != nil){
        CLLocation *oldTrajetDepart = [[CLLocation alloc]initWithLatitude:oldTrajet.depart.latitude.floatValue longitude:oldTrajet.depart.longitude.floatValue];
        if([mapView.userLocation.location distanceFromLocation:oldTrajetDepart] <= 5){
            nbCheckpointsOk ++;
        }else{
            isOk = false;
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Erreur" message:@"Vous devez être à moins de 5 mètres du point de départ de l'ancien trajet pour pouvoir le démarrer" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
            [alert show];
        }
    }
    
    if(isOk){
        self.navigationItem.hidesBackButton = YES;
        NSDate *date = [NSDate new];
        
        switch (typeTrajet.integerValue) {
            case CIRCUITS_STORE:
                trajet = [[Circuit alloc]init];
                getTours = false;
                getCheckpointTours = false;
                break;
                
            case PARCOURS_STORE:
                trajet = [[Parcours alloc]init];
                break;
                
            case ANCIEN_PARCOURS:
                if(oldTrajet != nil){
                    if([oldTrajet isKindOfClass:[Parcours class]]){
                        trajet = [[Parcours alloc]init];
                    }else{
                        trajet = [[Circuit alloc]init];
                    }
                }
                break;
                
            default:
                trajet = [[Parcours alloc]init];
                break;
        }
               
        
        [trajet setDateTrajet:date];
        
        Etape *firstEtape = [[Etape alloc] initWithLatitude:[NSNumber numberWithDouble:mapView.userLocation.coordinate.latitude] longitude:[NSNumber numberWithDouble:mapView.userLocation.coordinate.longitude]];
        
        
        
        [trajet setDepart:firstEtape];
        [[trajet trajetReel]addObject:firstEtape];
        
        MapPin *checkpoint = [[MapPin alloc]initWithCoordinates:mapView.userLocation.coordinate placeName:@"Checkpoint" description:@"Départ"];
        
        [checkpoint setIsDepart:[NSNumber numberWithBool:YES]];
        
        nbCheckpoints++;
           
        [[trajet checkpoints]addObject:checkpoint];
        
        timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(affichageInfos) userInfo:nil repeats:YES];
        
        btnState = false;
        [btnStartStop setTitle:@"STOP" forState:UIControlStateNormal];
        [btnPause setEnabled:YES];
    }
}

-(void)pauseTrajet
{
    if(!pauseTrajet){
        [timer invalidate];
        [btnPause setEnabled:NO];
        [btnStartStop setTitle:@"START" forState:UIControlStateNormal];
        pausePointLocation = [[CLLocation alloc]initWithLatitude:mapView.userLocation.coordinate.latitude longitude:mapView.userLocation.coordinate.longitude];
        pauseTrajet = true;
        btnState = true;
    }else{
        if([mapView.userLocation.location distanceFromLocation:pausePointLocation] <= 5){
                
            timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(affichageInfos) userInfo:nil repeats:YES];
            pauseTrajet = false;
            btnState = false;
            [btnStartStop setTitle:@"STOP" forState:UIControlStateNormal];
            [btnPause setEnabled:YES];
        }else{
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Erreur" message:@"Vous devez être à moins de 5 mètres de l'endroit ou vous avez mis en pause le trajet, pour pouvoir le continuer" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
}

-(void)stopTrajet
{
    NSLog(@"StopTrajet");
    [trajet setArrivee:[[Etape alloc] initWithLatitude:[NSNumber numberWithDouble:mapView.userLocation.coordinate.latitude] longitude:[NSNumber numberWithDouble:mapView.userLocation.coordinate.longitude]]];
    
        
    [trajet setDistance:[self calculDistance:trajet.trajetReel]];
    
    MapPin *checkpoint = [[MapPin alloc]initWithCoordinates:mapView.userLocation.coordinate placeName:@"Checkpoint" description:@"Arrivée"];
    [checkpoint setIsArrivee:[NSNumber numberWithBool:YES]];
    
    [[trajet checkpoints]addObject:checkpoint];
    nbCheckpoints++;
    NSLog(@"Distance : %@", trajet.distance);
    
    [trajet setIsUpdatable:[NSNumber numberWithBool:NO]];
    
    
    btnState = true;
    [btnStartStop setTitle:@"START" forState:UIControlStateNormal];
    [btnPause setEnabled:NO];
    
    if(typeTrajet.integerValue != ANCIEN_PARCOURS){
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Nouveau trajet"
                                                        message:@"Veuillez renseigner un nom"
                                                       delegate:self  cancelButtonTitle:@"Annuler"
                                              otherButtonTitles:@"OK", nil];

        
        [alert setAlertViewStyle:UIAlertViewStylePlainTextInput];
        
        // Customise name field
        txtNameAlert = [alert textFieldAtIndex:0];
        txtNameAlert.placeholder = @"Nom du trajet";
        txtNameAlert.clearButtonMode = UITextFieldViewModeWhileEditing;
        txtNameAlert.keyboardType = UIKeyboardTypeAlphabet; 
        txtNameAlert.keyboardAppearance = UIKeyboardAppearanceAlert;
        
        [alert show];
        self.navigationItem.hidesBackButton = NO;
    }else{
        if(oldTrajet != nil){
            if(nbCheckpointsOk >= oldTrajet.checkpoints.count){            
                [cache addTrajet:oldTrajet addTrajet:trajet];
                self.navigationItem.hidesBackButton = NO;
                NSLog(@"Trajet ajouté");
            }else{
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Erreur" message:@"Vous n'êtes pas passé par tous les checkpoints\nImpossible d'enregistrer ce nouveau trajet" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                [alert show];
            }
        }
    }
    
    [timer invalidate];
}

-(NSNumber *)calculDistance:(NSMutableArray *)etapes
{
    int distance = 0;
    int i = 0;
    Etape *oldEtape;
    
    for (Etape *etape in etapes) {
        if(i==0){
            oldEtape = etape;
        }else{
            CLLocation *oldLocation = [[CLLocation alloc]initWithLatitude:oldEtape.latitude.floatValue longitude:oldEtape.longitude.floatValue];
            CLLocation *nxLocation  = [[CLLocation alloc]initWithLatitude:etape.latitude.floatValue longitude:etape.longitude.floatValue];
            
            distance += [oldLocation distanceFromLocation:nxLocation];
            
            oldEtape = etape;
        }
        i++;
    }
    return [NSNumber numberWithInt:distance];
}

-(void)tracerTrajet:(Trajet *)pTrajet
{
    CLLocationCoordinate2D coors[pTrajet.trajetReel.count];
    
    int i = 0;
    for (Etape *etape in pTrajet.trajetReel) {
        CLLocation *location = [[CLLocation alloc]initWithLatitude:etape.latitude.floatValue longitude:etape.longitude.floatValue];
        
        coors[i] = location.coordinate;
        i++;
    }

    UIColor *colorLine = [[UIColor alloc]init];
    
    if(pTrajet.isUpdatable.boolValue){
        colorLine = [UIColor greenColor];
    }else{
        colorLine = [UIColor redColor];
    }
    
    
    Polyline *line = [Polyline polylineWithCoordinates:coors count:pTrajet.trajetReel.count color:colorLine];
    
    [self.mapView addOverlay:line];
}

-(void)affichageInfos
{
    
    if(trajet != nil && !btnState){
        
        //Incrémentation du temps du tour si c'est un circuit
        if([trajet isKindOfClass:[Circuit class]]){
            tempsTours ++;
        }
        
        trajet.tempsTrajet = [NSNumber numberWithInt:trajet.tempsTrajet.integerValue + 1];
        
        //Affichage du temps écoulé
        lblTempsEcoule.text = [Tools secondToString:trajet.tempsTrajet.integerValue];
        
        //Affichage de la distance
        NSNumber *distance = [self calculDistance:trajet.trajetReel];
      
        lblDistance.text = [Tools meterToString:distance.integerValue];
    }
}

-(void)showNbTours
{
    [nbToursView removeFromSuperview];
    
    if(trajet != nil){
        nbToursView = [[UIView alloc]initWithFrame:CGRectMake(230, 30, 75, 20)];
        
        
        NSString *text;
        if(((Circuit *)trajet).tempsTour.count <= 1){
            text = [NSString stringWithFormat:@" %i tour ",((Circuit *)trajet).tempsTour.count];
        }else{
            text = [NSString stringWithFormat:@" %i tours ",((Circuit *)trajet).tempsTour.count];
        }
        
        CGSize size = [text sizeWithFont:[UIFont systemFontOfSize:17]];
        
        UILabel *labelInfo = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, size.width, 20)];
        [labelInfo setText:text];
        [labelInfo setTag:10];
        //[labelInfo setBackgroundColor:[UIColor blackColor]];
        [labelInfo setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.7]];
        [labelInfo setTextColor:[UIColor whiteColor]];
        [labelInfo.layer setCornerRadius:8];
        [nbToursView addSubview:labelInfo];
    
        [self.view addSubview:nbToursView];
    }
}

-(void)viewWillDisappear:(BOOL)animated
{
    [timer invalidate];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 0){
        [trajet setNom:[Tools dateToFullString:trajet.dateTrajet]];
        [cache store:trajet];
        trajet= nil;
        [self.navigationController popToRootViewControllerAnimated:YES];
    }else{
        if(![txtNameAlert.text isEqualToString:@""]){
            if(![cache trajetNameExist:txtNameAlert.text]){
                [trajet setNom:txtNameAlert.text];
                [cache store:trajet];
                trajet= nil;
            }else{
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Nouveau trajet"
                                                                message:@"Le nom saisie existe déjà"
                                                               delegate:self  cancelButtonTitle:@"Annuler"
                                                      otherButtonTitles:@"OK", nil];
                
                
                [alert setAlertViewStyle:UIAlertViewStylePlainTextInput];
                
                // Customise name field
                txtNameAlert = [alert textFieldAtIndex:0];
                txtNameAlert.placeholder = @"Nom du trajet";
                txtNameAlert.clearButtonMode = UITextFieldViewModeWhileEditing;
                txtNameAlert.keyboardType = UIKeyboardTypeAlphabet;
                txtNameAlert.keyboardAppearance = UIKeyboardAppearanceAlert;
                
                [alert show];

            }
        }else{
            [trajet setNom:[Tools dateToFullString:trajet.dateTrajet]];
            [cache store:trajet];
            trajet= nil;
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
    }    
}

@end
