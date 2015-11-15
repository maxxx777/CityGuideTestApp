//
//  MTAddNewPlaceAssembly.m
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 14.11.15.
//  Copyright © 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTAddNewPlaceAssembly.h"
#import "TyphoonFactoryDefinition.h"
#import "MTEditPlaceDetailPresenter.h"
#import "MTPlaceDetailConfigurator.h"
#import "MTItemOperator.h"

@interface MTAddNewPlaceAssembly ()

@end

@implementation MTAddNewPlaceAssembly

- (UIViewController *)viewControllerWithAppRouter:(id<MTAppRouterInterface>)appRouter
                                         delegate:(id<MTEditPlaceDetailDelegate>)delegate
{
    return [TyphoonDefinition withFactory:[self.viewComponentsAssembly baseStoryboard]
                                 selector:@selector(instantiateViewControllerWithIdentifier:)
                               parameters:^(TyphoonMethod *factoryMethod){
                                   [factoryMethod injectParameterWith:@"ItemDetailViewController"];
                               } configuration:^(TyphoonFactoryDefinition *definition){
                                   [definition injectProperty:@selector(presenter)
                                                         with:[self addNewPlacePresenterWithAppRouter:appRouter delegate:delegate]];
                               }];
}

- (id<MTItemDetailPresenterInterface>)addNewPlacePresenterWithAppRouter:(id<MTAppRouterInterface>)appRouter
                                                               delegate:(id<MTEditPlaceDetailDelegate>)delegate
{
    return [TyphoonDefinition withClass:[MTEditPlaceDetailPresenter class]
                          configuration:^(TyphoonDefinition *definition){
                              [definition useInitializer:@selector(initWithPlaceDetailConfigurator:itemOperator:editPlaceDetailDelegate:router:)
                                              parameters:^(TyphoonMethod *initializer) {
                                                  [initializer injectParameterWith:[self placeDetailConfiguratorWithAppRouter:appRouter
                                                                                                                     delegate:delegate]];
                                                  [initializer injectParameterWith:[self itemOperatorWithAppRouter:appRouter
                                                                                                         delegate:delegate]];
                                                  [initializer injectParameterWith:delegate];
                                                  [initializer injectParameterWith:appRouter];
                                              }];
                              [definition injectProperty:@selector(userInterface)
                                                    with:[self viewControllerWithAppRouter:appRouter
                                                                                  delegate:delegate]];
                          }];
}

- (id<MTPlaceDetailConfiguratorInputInterface>)placeDetailConfiguratorWithAppRouter:(id<MTAppRouterInterface>)appRouter
                                                                           delegate:(id<MTEditPlaceDetailDelegate>)delegate
{
    return [TyphoonDefinition withClass:[MTPlaceDetailConfigurator class]
                          configuration:^(TyphoonDefinition *definition){
                              [definition useInitializer:@selector(initWithNewItem)];
                              [definition injectProperty:@selector(outputs)
                                                    with:@[[self addNewPlacePresenterWithAppRouter:appRouter
                                                                                          delegate:delegate]]];
                          }];
}

- (id<MTItemOperatorInputInterface>)itemOperatorWithAppRouter:(id<MTAppRouterInterface>)appRouter
                                                     delegate:(id<MTEditPlaceDetailDelegate>)delegate
{
    return [TyphoonDefinition withClass:[MTItemOperator class]
                          configuration:^(TyphoonDefinition *definition){
                              [definition useInitializer:@selector(initWithItemListCache:itemDataManager:)
                                              parameters:^(TyphoonMethod *initializer) {
                                                  [initializer injectParameterWith:nil];
                                                  [initializer injectParameterWith:[self.dataComponentsAssembly itemDataManager]];
                                              }];
                              [definition injectProperty:@selector(outputs)
                                                    with:@[[self addNewPlacePresenterWithAppRouter:appRouter
                                                                                          delegate:delegate]]];
                          }];
}

@end
