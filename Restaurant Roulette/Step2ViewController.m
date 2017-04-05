//
//  Step2ViewController.m
//  Restaurant Roulette
//
//  Created by Wang Ri on 2/19/16.
//  Copyright © 2016 Wang Ri. All rights reserved.
//

#import "Step2ViewController.h"

@interface Step2ViewController ()

@end

@implementation Step2ViewController

- (void)tappedOnMarkSelector:(UITapGestureRecognizer *)sender{
    NSInteger tappedMarkIndex = sender.view.tag;
    [defaults setInteger:tappedMarkIndex forKey:sPriceLevelStorageKey];
    [defaults synchronize];
    
    [self setMark];
}

- (void)setMark{
    int priceLevel = (int)[defaults integerForKey:sPriceLevelStorageKey] ?: 0;
    
    for (int i = 0 ; i < self.collectionPriceLevel.count; i ++) {
        NSString *sImagePath = [NSString stringWithFormat:@"btn_level_%d", i + 1];
        NSString *sImagePathActived = [NSString stringWithFormat:@"btn_level_%d_active", i + 1];
        
        UIImageView *imvPriceLevel = [self.collectionPriceLevel objectAtIndex:i];
        if (priceLevel == i){
            [imvPriceLevel setImage:[UIImage imageNamed:sImagePathActived]];
        } else {
            [imvPriceLevel setImage:[UIImage imageNamed:sImagePath]];
        }
    }
}

- (void)pageInit{
    for (UIImageView *imvMarkSelector in self.collectionPriceLevel) {
        UITapGestureRecognizer *tapMark = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tappedOnMarkSelector:)];
        [imvMarkSelector setUserInteractionEnabled:YES];
        [imvMarkSelector addGestureRecognizer:tapMark];
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

- (IBAction)goPhrase3:(id)sender {
    Step3ViewController *vcStep3 = [[Step3ViewController alloc]init];
    vcStep3 = [self.storyboard instantiateViewControllerWithIdentifier:@"vcStep3"];
    [self.navigationController pushViewController:vcStep3 animated:YES];
}

@end
