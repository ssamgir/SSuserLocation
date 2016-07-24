//
//  ViewController.h
//  UserLocation
//
//  Created by Felix ITs 01 on 24/07/16.
//  Copyright © 2016 Aashish Tamsya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>


@interface ViewController : UIViewController <CLLocationManagerDelegate,MKMapViewDelegate>
{
    CLLocationManager *locationManager;
    CLGeocoder *geocoder;
    
}

@property (weak, nonatomic) IBOutlet MKMapView *mapView;


@property (weak, nonatomic) IBOutlet UILabel *labelAddress;


@property (weak, nonatomic) IBOutlet UILabel *labelSpeed;
@property (weak, nonatomic) IBOutlet UILabel *labelAltitude;

@property (weak, nonatomic) IBOutlet UILabel *labelLatitude;

@property (weak, nonatomic) IBOutlet UILabel *labelLongitude;
- (IBAction)userLocationButtonTapped:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *userLocationButton;

@end

