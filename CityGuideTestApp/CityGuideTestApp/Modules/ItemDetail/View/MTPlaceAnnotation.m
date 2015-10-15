//
//  MTAddressAnnotation.m
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 11.10.15.
//  Copyright © 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTPlaceAnnotation.h"

@implementation MTPlaceAnnotation
@synthesize coordinate = _coordinate;

- (instancetype)initWithCoordinate:(CLLocationCoordinate2D)coordinate {
    self = [super init];
    if (self) {
        
        _coordinate = coordinate;
        
    }
    return self;
}

- (void)dealloc
{
    DLog(@"%@ deallocated: %p", NSStringFromClass([self class]), self);
}

@end
