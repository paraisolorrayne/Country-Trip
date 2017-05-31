//
//  CountryMO.h
//  Country-Trip
//
//  Created by Zup Beta on 25/05/17.
//  Copyright © 2017 DevTech. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface CountryMO : NSManagedObject
@property (strong, nonatomic) NSString *idCountry;
@property (strong, nonatomic) NSString *iso;
@property (strong, nonatomic) NSString *shortname;
@property (strong, nonatomic) NSString *longname;
@property (strong, nonatomic) NSString *callingCode;
@property (strong, nonatomic) NSString *status;
@property (strong, nonatomic) NSString *culture;
@property (strong, nonatomic) NSString *posterString;
@end
