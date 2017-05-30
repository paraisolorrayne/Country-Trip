//
//  DateVisitedViewController.h
//  Country-Trip
//
//  Created by Lorrayne Paraiso on 28/05/17.
//  Copyright © 2017 DevTech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BasePopupViewController.h"
#import "DetailViewController.h"

@class DateVisitedViewController;
@protocol DateVisitedViewControllerDelegate <NSObject>
@optional
- (void) didClickOkOnSuccess: (DateVisitedViewController *)controller;

@end
@interface DateVisitedViewController : BasePopupViewController
+(instancetype) instantiateNewView;
@property (weak, nonatomic) id<DateVisitedViewControllerDelegate> delegate;
@property (strong, nonatomic) NSString *stringFromDate;
@end
