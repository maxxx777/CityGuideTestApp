//
//  ETAppSettingsConfigurator.m
//  UniversitySchedule
//
//  Created by MAXIM TSVETKOV on 22.06.15.
//  Copyright (c) 2015 Egar Technology Inc. All rights reserved.
//

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
    [[MTLocationManager sharedManager] detectCurrentLocation];
}

@end
