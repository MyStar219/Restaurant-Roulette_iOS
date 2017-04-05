//
//  RestInfo.h
//  Restaurant Roulette
//
//  Created by Wang Ri on 1/13/16.
//  Copyright © 2016 Wang Ri. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RestInfo : NSObject

@property (nonatomic, retain) NSString *sImageUrl;
@property (nonatomic, retain) NSString *sRestName;
@property (nonatomic, retain) NSString *sDistance;
@property (nonatomic, retain) NSString *sAddress;
@property (nonatomic, retain) NSString *sRatingUrl;
@property (nonatomic, retain) NSString *sRatingNumber;
@property (nonatomic, retain) UIImage *imgThumbnail;

@end
