//
//  Step3ViewController.h
//  Restaurant Roulette
//
//  Created by Wang Ri on 2/19/16.
//  Copyright © 2016 Wang Ri. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Step4ViewController.h"

@interface Step3ViewController : UIViewController

@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *collectionMark;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *collectionDistanceLevel;


- (IBAction)goPhrase2:(id)sender;
- (IBAction)goPhrase4:(id)sender;

@end
