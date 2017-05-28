//
//  ContinentPopupViewController.m
//  Country-Trip
//
//  Created by Lorrayne Paraiso on 27/05/17.
//  Copyright © 2017 DevTech. All rights reserved.
//

#import "ContinentPopupViewController.h"

@interface ContinentPopupViewController ()

@end

@implementation ContinentPopupViewController

+(instancetype) instantiateNewView {
    UIStoryboard *sb = [UIStoryboard storyboardWithName: @"Continent" bundle: nil];
    ContinentPopupViewController *ctrl = [sb instantiateViewControllerWithIdentifier: @"Continent"];
    return ctrl;
}

-(void)actionDismissPopup {
    [self dismissPopup:^{
        if ([self.delegate respondsToSelector:@selector(didClickOkOnSuccess:)]) {
            [self.delegate didClickOkOnSuccess:self];
        }
    }];
}

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

@end
