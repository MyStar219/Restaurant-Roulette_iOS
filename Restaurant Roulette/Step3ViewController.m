//
//  Step3ViewController.m
//  Restaurant Roulette
//
//  Created by Wang Ri on 2/19/16.
//  Copyright © 2016 Wang Ri. All rights reserved.
//

#import "Step3ViewController.h"

@interface Step3ViewController ()

@end

@implementation Step3ViewController

- (void)tappedOnMarkSelector:(UITapGestureRecognizer *)sender{
    NSInteger tappedMarkIndex = sender.view.tag;
    [defaults setInteger:tappedMarkIndex forKey:sDistanceLevelStorageKey];
    [defaults synchronize];
    
    [self setMark];
}

- (void)setMark{
    for (UIImageView *imvMark in self.collectionMark) {
        [imvMark setHidden:YES];
    }
    
    NSInteger distanceLevel = [defaults integerForKey:sDistanceLevelStorageKey] ?: 0;
    [((UIImageView *)[self.collectionMark objectAtIndex:distanceLevel]) setHidden:NO];
}

- (void)pageInit{
    for (UILabel *lblMarkSelector in self.collectionDistanceLevel) {
        UITapGestureRecognizer *tapMark = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tappedOnMarkSelector:)];
        [lblMarkSelector setUserInteractionEnabled:YES];
        [lblMarkSelector addGestureRecognizer:tapMark];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self pageInit];
    [self setMark];
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
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)goPhrase4:(id)sender {
    Step4ViewController *vcStep4 = [[Step4ViewController alloc]init];
    vcStep4 = [self.storyboard instantiateViewControllerWithIdentifier:@"vcStep4"];
    [self.navigationController pushViewController:vcStep4 animated:YES];
}

@end
