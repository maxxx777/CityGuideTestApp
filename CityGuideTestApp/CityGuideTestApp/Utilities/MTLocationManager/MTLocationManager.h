//
//  MTLocationManager.h
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 09.10.15.
//  Copyright © 2015 MAXIM TSVETKOV. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>

@interface MTLocationManager : NSObject
<
    CLLocationManagerDelegate
>

+ (MTLocationManager *)sharedManager;

- (void)detectCurrentLocation;
- (BOOL)isCurrentLocationDetected;
- (BOOL)isLocationWithLatitude:(NSNumber *)latitude
                     longitude:(NSNumber *)longitude
                  withinRadius:(NSNumber *)radius;

@end
