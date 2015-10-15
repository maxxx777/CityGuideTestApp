//
//  MTAppSettingsConfigurator.m
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 11.10.15.
//  Copyright © 2015 MAXIM TSVETKOV. All rights reserved.
//
/*
Initial app settings can be configured here.
*/

#import "MTAppSettingsConfigurator.h"
#import "MTLocationManager.h"

@interface MTAppSettingsConfigurator ()

@end

@implementation MTAppSettingsConfigurator

- (void)dealloc
{
    DLog(@"%@ deallocated: %p", NSStringFromClass([self class]), self);
}

#pragma mark - MTAppSettingsConfiguratorInterface

- (void)configureSettings
{
    [[MTLocationManager sharedManager] detectLocation]; //FIXME: move detect location on demand (e.g. when filter places around current location)
}

@end
