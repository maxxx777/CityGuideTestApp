//
//  ETAppSettingsConfigurator.m
//  UniversitySchedule
//
//  Created by MAXIM TSVETKOV on 22.06.15.
//  Copyright (c) 2015 Egar Technology Inc. All rights reserved.
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
    [[MTLocationManager sharedManager] detectLocation]; //TODO: move detect location on demand (e.g. when filter places around current location)
}

@end
