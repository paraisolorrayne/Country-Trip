//
//  BasePopupViewController.m
//  Country-Trip
//
//  Created by Lorrayne Paraiso on 27/05/17.
//  Copyright © 2017 DevTech. All rights reserved.
//

#import "BasePopupViewController.h"

@interface BasePopupViewController ()

@property (nonatomic) BOOL didCallWillAppear;

@end

@implementation BasePopupViewController

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (UIView *)popupView {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"not self isKindOfClass: %@", UILayoutGuide.class];
    NSArray *views = [self.view.subviews filteredArrayUsingPredicate:predicate];
    return [views firstObject];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (!self.didCallWillAppear) {
        self.didCallWillAppear = YES;
        UIView *popupView = [self popupView];
        CGFloat yPos = self.view.frame.size.height;
        popupView.transform = CGAffineTransformMakeTranslation(0, yPos);
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)presentInRootViewControllerOfViewController:(UIViewController *)controller completion:(void(^)(void))completion {
    while (controller.parentViewController) {
        controller = controller.parentViewController;
    }
    [self presentInViewController:controller completion:completion];
}

- (void)presentInViewController:(UIViewController *)controller completion:(void (^)(void))completion {
    [controller presentViewController:self animated:NO completion:^{
        [UIView animateWithDuration:.2f animations:^{
            self.view.backgroundColor = [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.5f];
            
        } completion:^(BOOL finished) {
            //            [UIView animateWithDuration:.15f delay:.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
            [UIView animateWithDuration:.5f delay:.0f usingSpringWithDamping:.5f initialSpringVelocity:1.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
                UIView *popupView = [self popupView];
                popupView.transform = CGAffineTransformIdentity;
                
            } completion:^(BOOL finished) {
                if (completion) {
                    completion();
                }
            }];
        }];
    }];
}

- (UIViewController *)currentlyPresentedViewController {
    UIViewController *controller = UIApplication.sharedApplication.keyWindow.rootViewController;
    
    if (!controller) {
        return nil;
    }
    
    UIViewController *controller_ = controller;
    while (controller_.presentedViewController != nil) {
        controller_ = controller_.presentedViewController;
    }
    
    return controller_;
}

- (void)presentInRootViewController:(void (^)(void))completion {
    UIViewController *ctrl = [self currentlyPresentedViewController];
    [self presentInViewController:ctrl completion:completion];
}

- (void)dismissPopup:(void(^)(void))completion {
    //    [UIView animateWithDuration:.15f delay:.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
    [UIView animateWithDuration:.5f delay:.0f usingSpringWithDamping:.5f initialSpringVelocity:1.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        UIView *popupView = [self popupView];
        CGFloat yPos = self.view.frame.size.height;
        popupView.transform = CGAffineTransformMakeTranslation(0, yPos);
        
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:.2f animations:^{
            self.view.backgroundColor = [UIColor clearColor];
            
        } completion:^(BOOL finished) {
            [self dismissViewControllerAnimated:NO completion:^{
                if (completion) {
                    completion();
                }
            }];
        }];
    }];
}

- (IBAction)dismissBasePopupViewController:(id)sender {
    [self dismissPopup:nil];
}

@end
