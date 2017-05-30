//
//  CountryPropertyObject.m
//  Country-Trip
//
//  Created by Lorrayne Paraiso on 25/05/17.
//  Copyright © 2017 DevTech. All rights reserved.
//

#import "CountryPropertyObject.h"

@implementation CountryPropertyObject
-(instancetype)initWithData: (NSDictionary *)jsonDataObject {
    self = [super init];
    if (self) {
        self.idCountry = jsonDataObject[@"id"];
        self.iso = jsonDataObject[@"iso"];
        self.shortname = jsonDataObject[@"shortname"];
        self.longname = jsonDataObject[@"longname"];
        self.callingCode = jsonDataObject[@"callingCode"];
        self.status = jsonDataObject[@"status"];
        self.culture = jsonDataObject[@"culture"];
    }
    return self;
}
@end
