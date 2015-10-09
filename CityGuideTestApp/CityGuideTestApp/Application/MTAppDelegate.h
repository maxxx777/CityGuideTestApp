//
//  MTAppDelegate.h
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 07.10.15.
//  Copyright (c) 2015 MAXIM TSVETKOV. All rights reserved.
//

@class MTAppModulesConnector;
@class MTAppSettingsConfigurator;

@interface MTAppDelegate : UIResponder
<
    UIApplicationDelegate
>
{
    MTAppModulesConnector *appModulesConnector;
    MTAppSettingsConfigurator *appSettingsConfigurator;
}

@end
