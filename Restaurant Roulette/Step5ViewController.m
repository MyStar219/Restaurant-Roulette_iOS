//
//  Step5ViewController.m
//  Restaurant Roulette
//
//  Created by Wang Ri on 2/19/16.
//  Copyright © 2016 Wang Ri. All rights reserved.
//

#import "Step5ViewController.h"

@interface Step5ViewController ()

@end

@implementation Step5ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

- (IBAction)cancelUberRequest:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)goPhrase4:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
