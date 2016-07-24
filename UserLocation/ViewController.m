//
//  ViewController.m
//  UserLocation
//
//  Created by Felix ITs 01 on 24/07/16.
//  Copyright © 2016 Aashish Tamsya. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    [locationManager requestWhenInUseAuthorization];
    
    [self initLocationManager];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    
}

-(void)initLocationManager {

    locationManager = [[CLLocationManager alloc]init];
    [locationManager requestAlwaysAuthorization];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    geocoder = [[CLGeocoder alloc]init];
    

    
    
}

#pragma mark CLLocationManagerDelegate


-(void)locationManager:(CLLocationManager *)manager didFinishDeferredUpdatesWithError:(NSError *)error {
    
    NSLog(@"ERROR : %@",error.localizedDescription);
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    CLLocation *currentLocation = [locations lastObject];
    
    MKCoordinateSpan span = MKCoordinateSpanMake(0.01, 0.01);
    
    MKCoordinateRegion region = MKCoordinateRegionMake(currentLocation.coordinate, span);
    
    [self.mapView setRegion:region animated:true];
    
    
    
    NSString *latitute = [NSString stringWithFormat:@"%f",currentLocation.coordinate.latitude];
    
    NSString *longitude = [NSString stringWithFormat:@"%f",currentLocation.coordinate.longitude];
    
    
    
    NSString *speed = [NSString stringWithFormat:@"%f",currentLocation.speed];
    NSString *altitude = [NSString stringWithFormat:@"%f",currentLocation.altitude];

    
    self.labelLatitude.text = latitute;
    self.labelLongitude.text = longitude;
    self.labelSpeed.text = speed;
    self.labelAltitude.text = altitude;
    
    [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        
        if (error) {
            NSLog(@"REVERSE GEOCODING : %@",error.localizedDescription);
        }
        else {
            
            
            if (placemarks > 0) {
                CLPlacemark *currentPlacemark = [placemarks lastObject];

                NSLog(@"%@",currentPlacemark.addressDictionary);
                
                NSArray *formattedAddressArray = [currentPlacemark.addressDictionary valueForKey:@"FormattedAddressLines"];
                
                NSLog(@"%@",formattedAddressArray);

                
                NSString *address = [formattedAddressArray componentsJoinedByString:@", "];
                
                NSLog(@"%@",address);

                address = [address stringByReplacingOccurrencesOfString:@"\"" withString:@""];
                
                NSLog(@"%@",address);
                
                self.labelAddress.text = address;
            }
            
            
            
        }
        
    }];
    
    
    [self.userLocationButton setTitle:@"Located" forState:UIControlStateNormal];
    
}




- (IBAction)userLocationButtonTapped:(id)sender {

    
    [locationManager startUpdatingLocation];
    [self.userLocationButton setTitle:@"Detecting..." forState:UIControlStateNormal];
    
}

#pragma mark MKMapViewDelegate

-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
    
    NSLog(@"User LOcation : %@",userLocation);
}


@end
