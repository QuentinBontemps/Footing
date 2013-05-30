//
//  MapViewController.h
//  Footing
//
//  Created by admin on 18/04/13.
//  Copyright (c) 2013 Quentin Bontemps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import <AudioToolbox/AudioToolbox.h>
#import <QuartzCore/QuartzCore.h>
#import "Etape.h"
#import "Constant.h"
#import "Circuit.h"
#import "Parcours.h"
#import "Cache.h"
#import "Polyline.h"
#import "MapPin.h"
#import "Tools.h"

@interface MapViewController : UIViewController<MKMapViewDelegate, CLLocationManagerDelegate,UIAlertViewDelegate>
{
    CLLocationManager *locationManager;
    
    Cache *cache;
    
    BOOL btnState, pauseTrajet, getTours, getCircuitCheckpoint, getCheckpointTours;
    int nbCheckpoints,nbCheckpointsOk;
    
    NSTimer *timer;
    
    UIView *nbToursView;
    
    float locLat, locLon;
    int tempsTours;
    
    UITextField* txtNameAlert;
}

@property (strong, nonatomic) Trajet *trajet;
@property (strong, nonatomic) Trajet *oldTrajet;

@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) IBOutlet UIButton *btnStartStop;
@property (strong, nonatomic) IBOutlet UIButton *btnPause;
@property (strong, nonatomic) IBOutlet UILabel *lblDistance;
@property (strong, nonatomic) IBOutlet UILabel *lblTempsEcoule;

@property (strong, nonatomic) NSNumber *typeTrajet;

-(IBAction)btnStartStopOnClick:(id)sender;
-(IBAction)btnPauseOnClick:(id)sender;

@end
