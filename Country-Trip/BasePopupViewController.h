//
//  BasePopupViewController.h
//  Country-Trip
//
//  Created by Lorrayne Paraiso on 27/05/17.
//  Copyright © 2017 DevTech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BasePopupViewController : UIViewController
- (void)presentInRootViewControllerOfViewController:(UIViewController *)controller completion:(void(^)(void))completion;

- (void)presentInViewController:(UIViewController *)controller completion:(void(^)(void))completion;

- (void)presentInRootViewController:(void (^)(void))completion;

- (void)dismissPopup:(void(^)(void))completion;

- (IBAction)dismissBasePopupViewController:(id)sender;
@end
