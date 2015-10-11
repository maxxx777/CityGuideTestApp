//
//  ETAddressAnnotation.m
//  UniversitySchedule
//
//  Created by Grigory Avdyushin on 2/18/13.
//  Copyright (c) 2013 Grigory Avdyushin. All rights reserved.
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
