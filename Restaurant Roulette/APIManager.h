//
//  APIManager.h
//  TaxiApp
//
//  Created by Luokey on 4/11/16.
//  Copyright © 2016 Luokey. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface APIManager : NSObject

+ (APIManager*)sharedManager;
- (AFHTTPRequestOperationManager*)operationManager;

- (instancetype)init;

- (void)getUberPriceWithStartLatitude:(CLLocationDegrees)startLatitude
                       startLongitude:(CLLocationDegrees)startLongitude
                          endLatitude:(CLLocationDegrees)endLatitude
                         endLongitude:(CLLocationDegrees)endLongitude
                              success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                              failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;
- (void)getLyftPriceWithStartLatitude:(CLLocationDegrees)startLatitude
                       startLongitude:(CLLocationDegrees)startLongitude
                          endLatitude:(CLLocationDegrees)endLatitude
                         endLongitude:(CLLocationDegrees)endLongitude
                              success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                              failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;


@end
