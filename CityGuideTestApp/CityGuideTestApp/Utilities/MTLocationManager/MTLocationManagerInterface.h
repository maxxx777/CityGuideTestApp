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
- (BOOL)isLocationEnabled;
- (NSDictionary *)currentLocation;
- (BOOL)isLocationWithLatitude:(NSNumber *)latitude
                     longitude:(NSNumber *)longitude
                  withinRadius:(NSNumber *)radius;

@end
