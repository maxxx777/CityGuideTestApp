//
//  MTAppDelegate.h
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 07.10.15.
//  Copyright (c) 2015 MAXIM TSVETKOV. All rights reserved.
//

@protocol MTAppSettingsConfiguratorInterface;
@protocol MTAppModulesConnectorInterface;

@interface MTAppDelegate : UIResponder
<
    UIApplicationDelegate
>

@property (nonatomic, strong) UIWindow *window;
@property (nonatomic, strong) id<MTAppSettingsConfiguratorInterface> appSettingsConfigurator;
@property (nonatomic, strong) id<MTAppModulesConnectorInterface> appModulesConnector;

@end
