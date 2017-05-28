//
//  ContinentPopupViewController.h
//  Country-Trip
//
//  Created by Lorrayne Paraiso on 27/05/17.
//  Copyright © 2017 DevTech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BasePopupViewController.h"

@class ContinentPopupViewController;
@protocol ContinentPopupViewControllerDelegate <NSObject>

@optional
- (void)didClickOkOnSuccess: (ContinentPopupViewController *)controller;
@end

@interface ContinentPopupViewController : BasePopupViewController
+(instancetype) instantiateNewView;
@property (weak, nonatomic) id<ContinentPopupViewControllerDelegate> delegate;
@end
