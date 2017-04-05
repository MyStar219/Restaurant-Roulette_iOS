//
//  Step1ViewController.h
//  Restaurant Roulette
//
//  Created by Wang Ri on 2/19/16.
//  Copyright © 2016 Wang Ri. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Step2ViewController.h"

@interface Step1ViewController : UIViewController<CLLocationManagerDelegate>{
    CLLocationManager *locationManager;
    CLGeocoder *geocoder;
    CLPlacemark *placemark;
    BOOL canGetLocation;
}

- (IBAction)goPhrase2:(id)sender;


@end
