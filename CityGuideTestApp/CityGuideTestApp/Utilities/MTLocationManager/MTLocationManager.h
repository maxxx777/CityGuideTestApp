//
//  MTLocationManager.h
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 09.10.15.
//  Copyright © 2015 MAXIM TSVETKOV. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import "MTLocationManagerInterface.h"

@interface MTLocationManager : NSObject
<
    CLLocationManagerDelegate,
    MTLocationManagerInterface
>

- (instancetype) __unavailable init;

+ (MTLocationManager *)sharedManager;

@end
