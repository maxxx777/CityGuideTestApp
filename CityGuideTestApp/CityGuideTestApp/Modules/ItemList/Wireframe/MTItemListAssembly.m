//
//  MTItemListAssembly.m
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 07.11.15.
//  Copyright © 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTItemListAssembly.h"
#import "TyphoonFactoryDefinition.h"
#import "MTItemListViewController.h"
#import "MTItemListCollectionViewController.h"
#import "MTItemListTableViewController.h"
#import "MTItemListPresenter.h"
#import "MTItemListCollectionPresenter.h"
#import "MTItemListRequester.h"
#import "MTItemListExpander.h"
#import "MTFetchedResultsControllerBasedItemListCache.h"
#import "MTItemDataManager.h"

@interface MTItemListAssembly ()

@end

@implementation MTItemListAssembly

- (UIViewController *)viewControllerWithAppRouter:(id<MTAppRouterInterface>)appRouter
{
    return [TyphoonDefinition withFactory:[self.viewComponentsAssembly baseStoryboard]
                                 selector:@selector(instantiateViewControllerWithIdentifier:)
                               parameters:^(TyphoonMethod *factoryMethod){
                                   [factoryMethod injectParameterWith:@"ItemListViewController"];
                               } configuration:^(TyphoonFactoryDefinition *definition){
                                   [definition injectProperty:@selector(childViewController)
                                                         with:[self itemListChildViewControllerWithAppRouter:appRouter]];
                                   [definition injectProperty:@selector(presenter)
                                                         with:[self itemListPresenterWithAppRouter:appRouter]];
                               }];
}

- (MTItemListTableViewController *)itemListTableViewControllerWithAppRouter:(id<MTAppRouterInterface>)appRouter
{
    return [TyphoonDefinition withFactory:[self.viewComponentsAssembly baseStoryboard]
                                 selector:@selector(instantiateViewControllerWithIdentifier:)
                               parameters:^(TyphoonMethod *factoryMethod){
                                   [factoryMethod injectParameterWith:@"ItemListTableViewController"];
                               } configuration:^(TyphoonFactoryDefinition *definition){
                                   [definition injectProperty:@selector(presenter)
                                                         with:[self itemListCollectionPresenterWithAppRouter:appRouter]];
                               }];
}

- (MTItemListCollectionViewController *)itemListCollectionViewControllerWithAppRouter:(id<MTAppRouterInterface>)appRouter
{
    return [TyphoonDefinition withFactory:[self.viewComponentsAssembly baseStoryboard]
                                 selector:@selector(instantiateViewControllerWithIdentifier:)
                               parameters:^(TyphoonMethod *factoryMethod){
                                   [factoryMethod injectParameterWith:@"ItemListCollectionViewController"];
                               } configuration:^(TyphoonFactoryDefinition *definition){
                                   [definition injectProperty:@selector(presenter)
                                                         with:[self itemListCollectionPresenterWithAppRouter:appRouter]];
                               }];
}

- (UIViewController<MTItemListCollectionViewInterface> *)itemListChildViewControllerWithAppRouter:(id<MTAppRouterInterface>)appRouter
{
    return [TyphoonDefinition withOption:@(IS_IPAD)
                                     yes:[self itemListCollectionViewControllerWithAppRouter:appRouter]
                                      no:[self itemListTableViewControllerWithAppRouter:appRouter]];
}

- (id<MTItemListPresenterInterface>)itemListPresenterWithAppRouter:(id<MTAppRouterInterface>)appRouter
{
    return [TyphoonDefinition withClass:[MTItemListPresenter class]
                          configuration:^(TyphoonDefinition *definition){
                              [definition useInitializer:@selector(initWithItemListRequester:router:)
                                              parameters:^(TyphoonMethod *initializer) {
                                                  [initializer injectParameterWith:[self itemListRequesterWithAppRouter:appRouter]];
                                                  [initializer injectParameterWith:appRouter];
                                              }];
                              [definition injectProperty:@selector(userInterface)
                                                    with:[self viewControllerWithAppRouter:appRouter]];
                          }];
}

- (id<MTItemListCollectionPresenterInterface>)itemListCollectionPresenterWithAppRouter:(id<MTAppRouterInterface>)appRouter
{
    return [TyphoonDefinition withClass:[MTItemListCollectionPresenter class]
                          configuration:^(TyphoonDefinition *definition){
                              [definition useInitializer:@selector(initWithItemListRequester:itemListExpander:router:)
                                              parameters:^(TyphoonMethod *initializer) {
                                                  [initializer injectParameterWith:[self itemListRequesterWithAppRouter:appRouter]];
                                                  [initializer injectParameterWith:[self itemListExpanderWithAppRouter:appRouter]];
                                                  [initializer injectParameterWith:appRouter];
                                              }];
                              [definition injectProperty:@selector(userInterface)
                                                    with:[self itemListChildViewControllerWithAppRouter:appRouter]];
                          }];
}

- (id<MTItemListRequesterInputInterface>)itemListRequesterWithAppRouter:(id<MTAppRouterInterface>)appRouter
{
    return [TyphoonDefinition withClass:[MTItemListRequester class]
                          configuration:^(TyphoonDefinition *definition){
                              [definition useInitializer:@selector(initWithCityListCache:placeListCache:itemDataManager:)
                                              parameters:^(TyphoonMethod *initializer){
                                                  [initializer injectParameterWith:[self.dataComponentsAssembly arrayBasedItemListCache]];
                                                  [initializer injectParameterWith:[self placeListCache]];
                                                  [initializer injectParameterWith:[self.dataComponentsAssembly itemDataManager]];
                              }];
                              [definition injectProperty:@selector(outputs)
                                                    with:@[[self itemListCollectionPresenterWithAppRouter:appRouter]]];
    }];
}

- (id<MTItemListExpanderInputInterface>)itemListExpanderWithAppRouter:(id<MTAppRouterInterface>)appRouter
{
    return [TyphoonDefinition withClass:[MTItemListExpander class]
                          configuration:^(TyphoonDefinition *definition){
                              [definition useInitializer:@selector(initWithCityListCache:placeListCache:itemDataManager:)
                                              parameters:^(TyphoonMethod *initializer){
                                                  [initializer injectParameterWith:[self.dataComponentsAssembly arrayBasedItemListCache]];
                                                  [initializer injectParameterWith:[self placeListCache]];
                                                  [initializer injectParameterWith:[self.dataComponentsAssembly itemDataManager]];
                                              }];
                              [definition injectProperty:@selector(outputs)
                                                    with:@[[self itemListCollectionPresenterWithAppRouter:appRouter]]];
                          }];
}

- (id<MTFetchedResultsControllerBasedItemListCacheInterface>)placeListCache
{
    return [TyphoonDefinition withClass:[MTFetchedResultsControllerBasedItemListCache class]
                          configuration:^(TyphoonDefinition *definition){
                              [definition useInitializer:@selector(initWithDelegate:)
                                              parameters:^(TyphoonMethod *initializer){
                                                  [initializer injectParameterWith:[self itemListCacheDelegate]];
                              }];
    }];
}

- (id<MTItemListCacheDelegate>)itemListCacheDelegate
{
    return [TyphoonDefinition withClass:[MTItemDataManager class]];
}

@end
