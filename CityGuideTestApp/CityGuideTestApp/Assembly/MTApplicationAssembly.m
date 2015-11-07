//
//  MTApplicationAssembly.m
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 07.11.15.
//  Copyright © 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTApplicationAssembly.h"
#import "MTAppDelegate.h"
#import "MTAppSettingsConfigurator.h"
#import "MTAppModulesConnector.h"

@interface MTApplicationAssembly ()

@property (nonatomic, strong) UIWindow *window;

@end

@implementation MTApplicationAssembly

#pragma mark - AppDelegate

- (MTAppDelegate *)appDelegate
{
    return [TyphoonDefinition withClass:[MTAppDelegate class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition injectProperty:@selector(window)
                                                    with:[self window]];
                              [definition injectProperty:@selector(appSettingsConfigurator)
                                                    with:[self appSettingsConfigurator]];
                              [definition injectProperty:@selector(appModulesConnector)
                                                    with:[self appModuleConnector]];
    }];
}

#pragma mark - Window

- (UIWindow *)window
{
    if (!_window) {
        _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    }
    return _window;
}

#pragma mark - AppSettingsConfigurator

- (id <MTAppSettingsConfiguratorInterface>)appSettingsConfigurator {
    return [TyphoonDefinition withClass:[MTAppSettingsConfigurator class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition injectMethod:@selector(configureSettings)
                                            parameters:nil];
                          }];
}

#pragma mark - AppSettingsConnector

- (id <MTAppModulesConnectorInterface>)appModuleConnector {
    return [TyphoonDefinition withClass:[MTAppModulesConnector class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition useInitializer:@selector(initWithWindow:)
                                              parameters:^(TyphoonMethod *initializer) {
                                                  [initializer injectParameterWith:[self window]];
                              }];
                              [definition injectMethod:@selector(configureDependencies)
                                            parameters:nil];
                              [definition injectMethod:@selector(showMainScreen)
                                            parameters:nil];
                          }];
}

@end
