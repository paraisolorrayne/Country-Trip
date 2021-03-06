//
//  ViewController.h
//  Country-Trip
//
//  Created by Lorrayne Paraiso on 25/05/17.
//  Copyright © 2017 DevTech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AFNetworking/UIImageView+AFNetworking.h>
#import "CountryService.h"
#import "CountryPropertyObject.h"
#import "CountryMO.h"
#import "CountryCollectionViewCell.h"
#import "DetailViewController.h"



@interface ViewController : UIViewController
@property (strong, nonatomic) NSArray <CountryPropertyObject *> *countryCollectionResults;
@end

