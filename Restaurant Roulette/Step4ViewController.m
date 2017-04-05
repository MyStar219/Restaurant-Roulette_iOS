//
//  Step4ViewController.m
//  Restaurant Roulette
//
//  Created by Wang Ri on 2/19/16.
//  Copyright © 2016 Wang Ri. All rights reserved.
//

#import "Step4ViewController.h"

@interface Step4ViewController ()

@end

@implementation Step4ViewController

#pragma mark - notification

- (void)showAlert:(NSString *)sMessage{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.lblEstimatedPrice setText:sMessage];
    });
}

#pragma mark - Uber button

- (void)hideUberButton{
    for (UIView *subview in self.viewUberRide.subviews) {
        [subview removeFromSuperview];
    }
}

- (void)addUberRideButton{
    [self hideUberButton];
    
    RequestButton *btnCallRide = [[RequestButton alloc] initWithColorStyle:RequestButtonColorStyleBlack];
    [self.viewUberRide addSubview:btnCallRide];
    
    [btnCallRide setProductID:[NSString stringWithFormat:@"%@%@", uberProductId, [NSString stringWithFormat:@"%f",[[NSDate date] timeIntervalSince1970] * 1000]]];
    
    [btnCallRide setPickupLocationWithLatitude:currentLocation.coordinate.latitude longitude:currentLocation.coordinate.longitude nickname:address address:nil];
    
    [btnCallRide setDropoffLocationWithLatitude:[jsonRestInfo[@"location"][@"coordinate"][@"latitude"] doubleValue] longitude:[jsonRestInfo[@"location"][@"coordinate"][@"longitude"] doubleValue] nickname:@"Target Restaurant" address:nil];
    
    [self centerButton:btnCallRide inView:self.viewUberRide];
}

// center button position inside each background UIView
- (void)centerButton:(RequestButton*)button inView:(UIView*)view {
    button.translatesAutoresizingMaskIntoConstraints = NO;
    
    // position constraints
    NSLayoutConstraint *horizontalConstraint = [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
    NSLayoutConstraint *verticalConstraint = [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
    
    // add constraints to view
    [view addConstraints:[NSArray arrayWithObjects:horizontalConstraint, verticalConstraint, nil]];
};

#pragma mark - Yelp apis

- (NSArray *)filterArray:(NSArray *)nearByRestaurantsJSON{
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    
    NSArray *arrDistanceInMetre = @[@(0.0), @(3.0), @(5.0), @(10.0), @(15.0), @(20.0)];
    NSInteger nDistanceIndex = [defaults integerForKey:sDistanceLevelStorageKey];
//    float minDistance = [[arrDistanceInMetre objectAtIndex:nDistanceIndex] floatValue] * convertMileToKilometre * 1000.0;
    float maxDistance = [[arrDistanceInMetre objectAtIndex:nDistanceIndex + 1] floatValue] * convertMileToKilometre * 1000.0;
    
    for (NSDictionary *jsonDict in nearByRestaurantsJSON) {
        float distanceInMeter = [jsonDict[@"distance"] floatValue];
        
        if (distanceInMeter >= 0 && distanceInMeter <= maxDistance){
            [arr addObject:jsonDict];
        }
    }
    
    return (NSArray *)arr;
}

- (void)getUberPrices:(int)nth{
    if (nth == arrResInfos1.count){
        [SVProgressHUD dismiss];
        int pickedIndex = rand() % arrResInfos2.count;
        jsonRestInfo = [arrResInfos2 objectAtIndex:pickedIndex];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            restLocation = [[CLLocation alloc]initWithLatitude:[jsonRestInfo[@"location"][@"coordinate"][@"latitude"] floatValue] longitude:[jsonRestInfo[@"location"][@"coordinate"][@"longitude"] floatValue]];
            restAddress1 = jsonRestInfo[@"location"][@"display_address"][0];
            restAddress2 = jsonRestInfo[@"location"][@"display_address"][1];
            
            NSArray *arrMiles = @[@(3), @(5), @(10), @(15), @(20)];
            NSInteger nMile = [defaults integerForKey:sDistanceLevelStorageKey] ?: 0;
            nMile = [[arrMiles objectAtIndex:nMile] integerValue];
            
            [self.lblFound setText:[NSString stringWithFormat:@"We found a restaurant fitting\nyour description %@ mile%@ away.", @(nMile), nMile <= 1 ? @"" : @"s"]];
            [self.lblFound setHidden:NO];
            [self.imvFound setHidden:NO];
            
            NSString *sDisplayText = [NSString stringWithFormat:@"Estimated Uber fare: %@", [arrEstimatePrices objectAtIndex:pickedIndex]];
            NSMutableAttributedString *stringText = [[NSMutableAttributedString alloc] initWithString:sDisplayText];
            
            [stringText addAttribute: NSFontAttributeName value: [UIFont fontWithName:@"HelveticaNeue-Thin" size:18] range: NSMakeRange(21, sDisplayText.length - 21)];
            // Sets the font color of last four characters to green.
            self.lblEstimatedPrice.attributedText = stringText;
            
            
            [self.lblEstimatedPrice setHidden:NO];
            
            NSLog(@"*********************%@************************\n%@ %@", restLocation, restAddress1, restAddress2);
            [getLocationTimer invalidate];
            [self initialMap:restLocation title:@"Target Restaurant" subtitle:@""];
            [self addUberRideButton];
        });
        return;
    }
    
    NSDictionary *jsonRestTempInfo = [arrResInfos1 objectAtIndex:nth];
    CLLocation *restTempLocation = [[CLLocation alloc]initWithLatitude:[jsonRestTempInfo[@"location"][@"coordinate"][@"latitude"] floatValue] longitude:[jsonRestTempInfo[@"location"][@"coordinate"][@"longitude"] floatValue]];
    
    [[APIManager sharedManager] getUberPriceWithStartLatitude:currentLocation.coordinate.latitude startLongitude:currentLocation.coordinate.longitude endLatitude:restTempLocation.coordinate.latitude endLongitude:restTempLocation.coordinate.longitude success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"Low Price: %@, High Price: %@, Time: %@", responseObject[key_prices][0][@"low_estimate"], responseObject[key_prices][0][@"high_estimate"], responseObject[key_prices][0][@"duration"]);
        
        NSInteger highPrice = [responseObject[key_prices][0][@"high_estimate"] integerValue];
        NSInteger nPriceLevelIndex = [defaults integerForKey:sPriceLevelStorageKey];
        NSArray *arrPrices = @[@(1), @(15), @(25), @(100000)];

        NSInteger sI = [[arrPrices objectAtIndex:nPriceLevelIndex] integerValue];
        NSInteger eI = [[arrPrices objectAtIndex:nPriceLevelIndex + 1] integerValue];
        if (highPrice >= sI && highPrice < eI){
            [arrResInfos2 addObject:jsonRestTempInfo];
            [arrEstimatePrices addObject:responseObject[key_prices][0][@"estimate"]];
        }
        
        [self getUberPrices:nth + 1];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"ERROR (Uber) : %@", [error localizedDescription]);
    }];
}

- (void)doYelpRequest{
    [SVProgressHUD showWithStatus:@"Searching..."];
    
    @autoreleasepool {
        NSString *term = @"restaurants";
        NSString *cll = [NSString stringWithFormat:@"%f,%f", currentLocation.coordinate.latitude, currentLocation.coordinate.longitude];
        NSString *limit = [defaults valueForKey:limitStorageKey] ?: defaultLimit;
        NSString *sort = [defaults valueForKey:sortStorageKey] ?: defaultSort;
        NSString *radius_filter = [defaults valueForKey:radiusStorageKey] ?: defaultRadiusFilter;
        
        YPAPISample *APISample = [[YPAPISample alloc] init];
        
        dispatch_group_t requestGroup = dispatch_group_create();
        
        dispatch_group_enter(requestGroup);
        
        [APISample queryNearbyRestaurantsInfoForTerm:term ll:cll limit:limit sort:sort radius_filter:radius_filter completionHandler:^(NSArray *nearByRestaurantsJSON, NSError *error) {
            
            if (error) {
                [SVProgressHUD dismiss];
                [self showAlert:[NSString stringWithFormat:@"An error happened during the request: %@", error]];
            } else if (nearByRestaurantsJSON.count > 0) {
                arrResInfos1 = [nearByRestaurantsJSON mutableCopy];
                arrResInfos2 = [[NSMutableArray alloc]init];
                arrEstimatePrices = [[NSMutableArray alloc]init];
                
                [self getUberPrices:0];
            } else {
                [SVProgressHUD dismiss];
                [self showAlert:@"No Restaurant was found"];
            }
            
            dispatch_group_leave(requestGroup);
        }];
        
        dispatch_group_wait(requestGroup, DISPATCH_TIME_FOREVER); // This avoids the program exiting before all our asynchronous callbacks have been made.
    }
}

#pragma mark - show map

- (void)addAnnotation:(CLLocation *)location title:(NSString *)title subtitle:(NSString *)subtitle{
    MGLPointAnnotation *point = [[MGLPointAnnotation alloc] init];
    point.coordinate = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude);
    point.title = title;
    point.subtitle = subtitle;
    
    [_mapView addAnnotation:point];
}

- (void)initialMap:(CLLocation *)location title:(NSString *)title subtitle:(NSString *)subtitle{
    [_mapView removeFromSuperview];
    
    _mapView = [[MGLMapView alloc] initWithFrame:self.viewMap.bounds];
//    mapView = [[MGLMapView alloc] initWithFrame:self.view.bounds styleURL:[MGLStyle darkStyleURL]];
    _mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [_mapView setCenterCoordinate:CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude) animated:NO];
    [_mapView setZoomLevel:15];
    [self.viewMap addSubview:_mapView];
    
    [_mapView removeAnnotations:_mapView.annotations];
    [self addAnnotation:location title:title subtitle:subtitle];
    
    _mapView.delegate = self;
}

#pragma mark - map view delegate

// Always show a callout when an annotation is tapped.
- (BOOL)mapView:(MGLMapView *)mapView annotationCanShowCallout:(id <MGLAnnotation>)annotation {
    return YES;
}

#pragma mark - initializeing

- (void)keepFindCurrentLocation{
    if (currentLocation == nil){
        
    } else {
        [self initialMap:currentLocation title:@"My Location" subtitle:address];
        [getLocationTimer invalidate];
    }
}

- (void)loadGetLocationTimer{
    getLocationTimer = [NSTimer scheduledTimerWithTimeInterval:.1 target:self selector:@selector(keepFindCurrentLocation) userInfo:nil repeats:YES];
}

#pragma mark - default methods

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadGetLocationTimer];
    [self doYelpRequest];
}

- (void)viewDidAppear:(BOOL)animated{
    
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

- (IBAction)goPhrase3:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)goPhrase5:(id)sender {
    Step5ViewController *vcStep5 = [[Step5ViewController alloc]init];
    vcStep5 = [self.storyboard instantiateViewControllerWithIdentifier:@"vcStep5"];
    [self.navigationController pushViewController:vcStep5 animated:YES];
}

@end
