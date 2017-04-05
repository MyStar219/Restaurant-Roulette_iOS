//
//  GlobalScope.h
//  Restaurant Roulette
//
//  Created by Wang Ri on 1/12/16.
//  Copyright © 2016 Wang Ri. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface GlobalScope : NSObject

extern NSString *APP_NAME;
extern CLLocation *restLocation;
extern NSString *restAddress1;
extern NSString *restAddress2;
extern UIColor *iOS7LineColor;
extern NSString *limitStorageKey;
extern NSString *radiusStorageKey;
extern NSString *sortStorageKey;
extern NSString *distanceUnitStorageKey;
extern NSString *defaultLimit;
extern NSString *defaultSort;
extern NSString *defaultRadiusFilter;
extern CLLocation *currentLocation;
extern NSString *address;
extern NSString *uberProductId;
extern CGFloat convertMileToKilometre;
extern NSArray *arrPriceLevels;
extern NSUserDefaults *defaults;
extern NSString *sPriceLevelStorageKey;
extern NSString *sDistanceLevelStorageKey;

@end
