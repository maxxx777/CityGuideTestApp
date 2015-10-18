//
//  MTLocationManagerInterface.h
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 14.10.15.
//  Copyright © 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTLocationManagerConstants.h"

@protocol MTLocationManagerInterface <NSObject>

- (void)detectLocation;
@property (NS_NONATOMIC_IOSONLY, getter=isLocationEnabled, readonly) BOOL locationEnabled;
@property (NS_NONATOMIC_IOSONLY, readonly, copy) NSDictionary * _Nullable currentLocation;
- (BOOL)isLocationWithLatitude:(NSNumber * _Nonnull)latitude
                     longitude:(NSNumber * _Nonnull)longitude
                  withinRadius:(NSNumber * _Nonnull)radius;

@end
