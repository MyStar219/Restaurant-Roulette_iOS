//
//  Step2ViewController.h
//  Restaurant Roulette
//
//  Created by Wang Ri on 2/19/16.
//  Copyright © 2016 Wang Ri. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Step3ViewController.h"

@interface Step2ViewController : UIViewController

@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *collectionPriceLevel;

- (IBAction)goPhrase3:(id)sender;

@end
