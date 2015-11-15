//
//  MTImageBrowserAssembly.m
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 08.11.15.
//  Copyright © 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTImageBrowserAssembly.h"
#import "TyphoonFactoryDefinition.h"
#import "MTImageBrowserViewController.h"
#import "MTImageBrowserPresenter.h"

@interface MTImageBrowserAssembly ()

@end

@implementation MTImageBrowserAssembly

- (UIViewController *)viewControllerWithAppRouter:(id<MTAppRouterInterface>)appRouter
                                            image:(UIImage *)image
{
    return [TyphoonDefinition withFactory:[self.viewComponentsAssembly baseStoryboard]
                                 selector:@selector(instantiateViewControllerWithIdentifier:)
                               parameters:^(TyphoonMethod *factoryMethod){
                                   [factoryMethod injectParameterWith:@"ImageBrowserViewController"];
                               } configuration:^(TyphoonFactoryDefinition *definition){
                                   [definition injectProperty:@selector(presenter)
                                                         with:[self presenterWithAppRouter:appRouter image:image]];
                               }];
}

- (MTImageBrowserPresenter *)presenterWithAppRouter:(id<MTAppRouterInterface>)appRouter
                                              image:(UIImage *)image
{
    return [TyphoonDefinition withClass:[MTImageBrowserPresenter class]
                          configuration:^(TyphoonDefinition *definition){
                              [definition useInitializer:@selector(initWithImage:router:)
                                              parameters:^(TyphoonMethod *initializer) {
                                                  [initializer injectParameterWith:image];
                                                  [initializer injectParameterWith:appRouter];
                                              }];
                              [definition injectProperty:@selector(userInterface)
                                                    with:[self viewControllerWithAppRouter:appRouter image:image]];
                          }];
}

@end
