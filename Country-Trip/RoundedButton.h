//
//  RoundedButton.h
//  Country-Trip
//
//  Created by Lorrayne Paraiso on 27/05/17.
//  Copyright © 2017 DevTech. All rights reserved.
//

#import <UIKit/UIKit.h>


IB_DESIGNABLE
@interface RoundedButton : UIButton

@property (strong, nonatomic) IBInspectable UIColor *borderColor;
@property (nonatomic, readonly) IBInspectable CGFloat borderWidth;
@property (strong, nonatomic) IBInspectable UIColor *bgColor;
@property (strong, nonatomic, readonly) IBInspectable NSString *titleText;
@property (strong, nonatomic, readonly) IBInspectable NSString *subtitleText;

@end
