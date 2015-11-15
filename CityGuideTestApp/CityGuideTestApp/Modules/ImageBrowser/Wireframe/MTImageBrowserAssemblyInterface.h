//
//  MTImageBrowserAssemblyInterface.h
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 14.11.15.
//  Copyright © 2015 MAXIM TSVETKOV. All rights reserved.
//

@protocol MTAppRouterInterface;

@protocol MTImageBrowserAssemblyInterface <NSObject>

- (UIViewController *)viewControllerWithAppRouter:(id<MTAppRouterInterface>)appRouter
                                            image:(UIImage *)image;

@end
