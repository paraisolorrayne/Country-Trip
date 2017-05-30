//
//  DetailViewController.h
//  Country-Trip
//
//  Created by Lorrayne Paraiso on 26/05/17.
//  Copyright © 2017 DevTech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AFNetworking/UIImageView+AFNetworking.h>
#import "CountryPropertyObject.h"
#import "CountryMO.h"
#import "DateVisitedViewController.h"
#import "CountryVisitedTableViewController.h"

@interface DetailViewController : UIViewController
@property (strong, nonatomic) CountryPropertyObject *countryDetail;
@property (strong, nonatomic) CountryMO *countryData;
@property (strong, nonatomic) NSDate *dateTravel;
@end
