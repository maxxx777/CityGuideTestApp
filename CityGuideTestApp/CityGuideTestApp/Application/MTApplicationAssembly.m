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
#import "MTAppRouter.h"
#import "MTImageBrowserAssembly.h"
#import "MTShowPlaceDetailAssembly.h"
#import "MTItemListAssembly.h"
#import "MTAddNewPlaceAssembly.h"
#import "MTViewComponentsAssembly.h"

@interface MTApplicationAssembly ()

@property (nonatomic, strong) MTViewComponentsAssembly *viewComponentsAssembly;
@property (nonatomic, strong) MTItemListAssembly *itemListAssembly;
@property (nonatomic, strong) MTShowPlaceDetailAssembly *showPlaceDetailAssembly;
@property (nonatomic, strong) MTImageBrowserAssembly *imageBrowserAssembly;
@property (nonatomic, strong) MTAddNewPlaceAssembly *addNewPlaceAssembly;

@end

@implementation MTApplicationAssembly

#pragma mark - AppDelegate

- (MTAppDelegate *)appDelegate
{
    return [TyphoonDefinition withClass:[MTAppDelegate class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition injectProperty:@selector(window)
                                                    with:[self.viewComponentsAssembly window]];
                              [definition injectProperty:@selector(appSettingsConfigurator)
                                                    with:[self appSettingsConfigurator]];
                              [definition injectProperty:@selector(appRouter)
                                                    with:[self appRouter]];
    }];
}

#pragma mark - AppSettingsConfigurator

- (id <MTAppSettingsConfiguratorInterface>)appSettingsConfigurator {
    return [TyphoonDefinition withClass:[MTAppSettingsConfigurator class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition injectMethod:@selector(configureSettings)
                                            parameters:nil];
                          }];
}

#pragma mark - AppRouter

- (id <MTAppRouterInterface>)appRouter {
    return [TyphoonDefinition withClass:[MTAppRouter class]
                          configuration:^(TyphoonDefinition *definition) {
                              
                              //there are all modules of the app
                              [definition injectProperty:@selector(itemListAssembly)
                                                    with:self.itemListAssembly];
                              [definition injectProperty:@selector(showPlaceDetailAssembly)
                                                    with:self.showPlaceDetailAssembly];
                              [definition injectProperty:@selector(imageBrowserAssembly)
                                                    with:self.imageBrowserAssembly];
                              [definition injectProperty:@selector(addNewPlaceAssembly)
                                                    with:self.addNewPlaceAssembly];
                              
                              [definition injectMethod:@selector(showRootViewControllerInWindow:)
                                            parameters:^(TyphoonMethod *method){
                                                [method injectParameterWith:[self.viewComponentsAssembly window]];
                                            }];
                          }];
}

@end
