//
//  MTShowPlaceDetailAssemblyInterface.h
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 14.11.15.
//  Copyright © 2015 MAXIM TSVETKOV. All rights reserved.
//

@protocol MTAppRouterInterface;

@protocol MTShowPlaceDetailAssemblyInterface <NSObject>

- (UIViewController *)viewControllerWithAppRouter:(id<MTAppRouterInterface>)appRouter
                                             item:(id)item;

@end
