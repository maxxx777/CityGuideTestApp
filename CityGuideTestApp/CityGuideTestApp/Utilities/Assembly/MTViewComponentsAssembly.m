//
//  MTViewComponentsAssembly.m
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 14.11.15.
//  Copyright © 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTViewComponentsAssembly.h"
#import "TyphoonFactoryDefinition.h"

@implementation MTViewComponentsAssembly

- (UIWindow *)window
{
    return [TyphoonDefinition withClass:[UIWindow class] configuration:^(TyphoonDefinition *definition)
            {
                [definition useInitializer:@selector(initWithFrame:) parameters:^(TyphoonMethod *initializer)
                 {
                     [initializer injectParameterWith:[NSValue valueWithCGRect:[[UIScreen mainScreen] bounds]]];
                 }];
            }];
}

- (UIStoryboard *)baseStoryboard
{
    return [TyphoonDefinition withClass:[UIStoryboard class] configuration:^(TyphoonDefinition *definition) {
        [definition useInitializer:@selector(storyboardWithName:bundle:)
                        parameters:^(TyphoonMethod *initializer) {
                            [initializer injectParameterWith:@"Base"];
                            [initializer injectParameterWith:nil];
                        }];
    }];
}

@end
