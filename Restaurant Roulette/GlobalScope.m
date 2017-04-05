//
//  GlobalScope.m
//  Restaurant Roulette
//
//  Created by Wang Ri on 1/12/16.
//  Copyright © 2016 Wang Ri. All rights reserved.
//

#import "GlobalScope.h"

@implementation GlobalScope

NSString *APP_NAME = @"Restaurant Roulette";
CLLocation *restLocation;
NSString *restAddress1;
NSString *restAddress2;
UIColor *iOS7LineColor;
NSString *limitStorageKey = @"com.dev.wangri.restaurantRoulette.limit";
NSString *radiusStorageKey = @"com.dev.wangri.restaurantRoulette.radius";
NSString *sortStorageKey = @"com.dev.wangri.restaurantRoulette.sort";
NSString *defaultLimit = @"100";
NSString *defaultSort = @"0";
NSString *defaultRadiusFilter = @"40000";
CLLocation *currentLocation;
NSString *address;
NSString *uberProductId = @"BokFerOAGUSN7WVN2kkN5un812B29ddX";
NSString *distanceUnitStorageKey = @"com.dev.wangri.restaurantRoulette.unit";
CGFloat convertMileToKilometre = 1.60934;
NSArray *arrPriceLevels;
NSUserDefaults *defaults;
NSString *sPriceLevelStorageKey = @"com.dev.wangri.restaurantRoulette.priceLevel";
NSString *sDistanceLevelStorageKey = @"com.dev.wangri.restaurantRoulette.distanceLevel";

@end
