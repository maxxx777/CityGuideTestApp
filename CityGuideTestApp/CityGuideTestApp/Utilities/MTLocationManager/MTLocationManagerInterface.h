//
//  MTLocationManagerInterface.h
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 14.10.15.
//  Copyright © 2015 MAXIM TSVETKOV. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MTLocationManagerInterface <NSObject>

- (void)detectLocation;
@property (NS_NONATOMIC_IOSONLY, getter=isLocationEnabled, readonly) BOOL locationEnabled;
@property (NS_NONATOMIC_IOSONLY, readonly, copy) NSDictionary *currentLocation;
- (BOOL)isLocationWithLatitude:(NSNumber *)latitude
                     longitude:(NSNumber *)longitude
                  withinRadius:(NSNumber *)radius;

@end
