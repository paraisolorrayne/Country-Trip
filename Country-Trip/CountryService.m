//
//  CountryService.m
//  Country-Trip
//
//  Created by Zup Beta on 25/05/17.
//  Copyright © 2017 DevTech. All rights reserved.
//

#import "CountryService.h"
static NSString *const kUrlBase = @"http://awseb-e-e-awsebloa-c5zq0lwotmwj-832470836.us-east-1.elb.amazonaws.com";

@interface CountryService ()
@property (strong, nonatomic) AFHTTPSessionManager *manager;
@end

@implementation CountryService

+ (instancetype)defaultService {
    static CountryService *__defaultService = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __defaultService = [[CountryService alloc] init];
    });
    return __defaultService;
}

- (instancetype)init {
    if (self = [super init]) {
        self.manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString: kUrlBase] sessionConfiguration:nil];
        self.manager.requestSerializer = [AFJSONRequestSerializer new];
        [_manager.requestSerializer setTimeoutInterval:60];
        self.manager.responseSerializer = [AFJSONResponseSerializer new];
    }
    return self;
}

- (void)fetchCountries:(void (^)(NSArray<CountryPropertyObject *> *))success error:(void (^)(NSURLSessionDataTask *task, NSError *error))error {
    [self.manager GET:@"/world/countries/active" parameters:nil progress:nil success:^(NSURLSessionDataTask *task, id response) {
        NSMutableArray *countries;
        if ([response isKindOfClass:[NSArray class]]) {
            NSArray *responseArray = response;
            NSLog(@"%@", responseArray);
            countries = [NSMutableArray arrayWithCapacity:responseArray.count];
            for (NSDictionary *json in responseArray) {
                CountryPropertyObject *country = [[CountryPropertyObject alloc] initWithData:json];
                [countries addObject:country];
            }
            /* do something with responseArray */
        } else if ([response isKindOfClass:[NSDictionary class]]) {
            NSDictionary *responseDict = response;
            countries = [NSMutableArray arrayWithCapacity:responseDict.count];
            for (NSDictionary *json in responseDict) {
                CountryPropertyObject *country = [[CountryPropertyObject alloc] initWithData:json];
                [countries addObject:country];
            }
        }
        success(countries);
    } failure:error];
}

@end
