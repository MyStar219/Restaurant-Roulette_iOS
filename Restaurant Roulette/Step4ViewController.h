//
//  Step4ViewController.h
//  Restaurant Roulette
//
//  Created by Wang Ri on 2/19/16.
//  Copyright © 2016 Wang Ri. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Step5ViewController.h"
#import <Mapbox/Mapbox.h>

@interface Step4ViewController : UIViewController<MGLMapViewDelegate>{
    NSDictionary *jsonRestInfo;
    NSTimer *getLocationTimer;
    NSMutableArray *arrResInfos1;
    NSMutableArray *arrResInfos2;
    NSMutableArray *arrEstimatePrices;
}

@property (weak, nonatomic) IBOutlet UILabel *lblEstimatedPrice;
@property (weak, nonatomic) IBOutlet UIView *viewUberRide;
@property (weak, nonatomic) IBOutlet UILabel *lblFound;
@property (weak, nonatomic) IBOutlet UIView *viewMap;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *progressBar;
@property (weak, nonatomic) IBOutlet UIImageView *imvFound;
@property (nonatomic) IBOutlet MGLMapView *mapView;

- (IBAction)goPhrase3:(id)sender;
- (IBAction)goPhrase5:(id)sender;

@end
