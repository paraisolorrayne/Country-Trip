//
//  CountryService.h
//  Country-Trip
//
//  Created by Zup Beta on 25/05/17.
//  Copyright © 2017 DevTech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
#import "CountryPropertyObject.h"


@interface CountryService : NSObject

+ (instancetype)defaultService;
- (instancetype)init;
- (void)fetchCountries:(void (^)(NSArray<CountryPropertyObject *> *))success error:(void (^)(NSURLSessionDataTask *task, NSError *error))error;
@end
