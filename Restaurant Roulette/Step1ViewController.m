//
//  Step1ViewController.m
//  Restaurant Roulette
//
//  Created by Wang Ri on 2/19/16.
//  Copyright © 2016 Wang Ri. All rights reserved.
//

#import "Step1ViewController.h"

@interface Step1ViewController ()

@end


@implementation Step1ViewController

- (void)initLocationManager{
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    if ([locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
        [locationManager requestAlwaysAuthorization];
    }
    
    geocoder = [[CLGeocoder alloc] init];
    
    canGetLocation = true;
    
    [locationManager startUpdatingLocation];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    defaults = [NSUserDefaults standardUserDefaults];
    [self initLocationManager];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)goPhrase2:(id)sender {
    Step2ViewController *vcStep2 = [[Step2ViewController alloc]init];
    vcStep2 = [self.storyboard instantiateViewControllerWithIdentifier:@"vcStep2"];
    [self.navigationController pushViewController:vcStep2 animated:YES];
}

- (void)showAlert:(NSString *)sMessage{
//    NSLog(@"Message : %@", sMessage);
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    currentLocation = nil;    
    [self showAlert:@"Failed to Get Your Location"];
    canGetLocation = false;
}

- (void)getAddress:(CLLocation *)location{
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        if (error == nil && [placemarks count] > 0) {
            placemark = [placemarks lastObject];
            address = [NSString stringWithFormat:@"%@ %@\n%@ %@\n%@\n%@",
                       placemark.subThoroughfare, placemark.thoroughfare,
                       placemark.postalCode, placemark.locality,
                       placemark.administrativeArea,
                       placemark.country];
            
            address = [NSString stringWithFormat:@"%@ %@",
                       placemark.subThoroughfare, placemark.thoroughfare];
            
//            [locationManager stopUpdatingLocation];
        } else {
            NSLog(@"%@", error.debugDescription);
        }
    }];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation{
    currentLocation = newLocation;
    
//    currentLocation = [[CLLocation alloc] initWithLatitude:40.7330265 longitude:-73.9877553];
//    currentLocation = [[CLLocation alloc] initWithLatitude:26.122089 longitude:-80.13302199999998];
    
    [self getAddress:newLocation];
}


@end
