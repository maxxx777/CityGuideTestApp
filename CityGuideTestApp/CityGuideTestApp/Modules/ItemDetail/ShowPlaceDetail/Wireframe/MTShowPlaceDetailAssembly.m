//
//  MTShowPlaceDetailAssembly.m
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 09.11.15.
//  Copyright © 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTShowPlaceDetailAssembly.h"
#import "TyphoonFactoryDefinition.h"
#import "MTItemDetailViewController.h"
#import "MTShowPlaceDetailPresenter.h"
#import "MTPlaceDetailFetcher.h"

@interface MTShowPlaceDetailAssembly ()

@end

@implementation MTShowPlaceDetailAssembly

- (UIViewController *)viewControllerWithAppRouter:(id<MTAppRouterInterface>)appRouter
                                             item:(id)item
{
    return [TyphoonDefinition withFactory:[self.viewComponentsAssembly baseStoryboard]
                                 selector:@selector(instantiateViewControllerWithIdentifier:)
                               parameters:^(TyphoonMethod *factoryMethod){
                                   [factoryMethod injectParameterWith:@"ItemDetailViewController"];
                               } configuration:^(TyphoonFactoryDefinition *definition){
                                   [definition injectProperty:@selector(presenter)
                                                         with:[self showPlaceDetailPresenterWithAppRouter:appRouter item:item]];
                               }];
}

- (id<MTItemDetailPresenterInterface>)showPlaceDetailPresenterWithAppRouter:(id<MTAppRouterInterface>)appRouter
                                                                       item:(id)item
{
    return [TyphoonDefinition withClass:[MTShowPlaceDetailPresenter class]
                          configuration:^(TyphoonDefinition *definition){
                              [definition useInitializer:@selector(initWithPlaceDetailFetcher:router:)
                                              parameters:^(TyphoonMethod *initializer) {
                                                  [initializer injectParameterWith:[self placeDetailFetcherWithAppRouter:appRouter item:item]];
                                                  [initializer injectParameterWith:appRouter];
                                              }];
                              [definition injectProperty:@selector(userInterface)
                                                    with:[self viewControllerWithAppRouter:appRouter
                                                                                      item:item]];
                          }];
}

- (id<MTPlaceDetailFetcherInputInterface>)placeDetailFetcherWithAppRouter:(id<MTAppRouterInterface>)appRouter
                                                                     item:(id)item
{
    return [TyphoonDefinition withClass:[MTPlaceDetailFetcher class]
                          configuration:^(TyphoonDefinition *definition){
                              [definition useInitializer:@selector(initWithPlace:itemDataManager:)
                                              parameters:^(TyphoonMethod *initializer){
                                                  [initializer injectParameterWith:item];
                                                  [initializer injectParameterWith:[self.dataComponentsAssembly itemDataManager]];
                                              }];
                              [definition injectProperty:@selector(outputs)
                                                    with:@[[self showPlaceDetailPresenterWithAppRouter:appRouter
                                                                                                  item:item]]];
                          }];
}

@end
