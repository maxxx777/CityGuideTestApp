//
//  MTAddNewPlaceAssemblyInterface.h
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 14.11.15.
//  Copyright © 2015 MAXIM TSVETKOV. All rights reserved.
//

@protocol MTAppRouterInterface;
@protocol MTEditPlaceDetailDelegate;

@protocol MTAddNewPlaceAssemblyInterface <NSObject>

- (UIViewController *)viewControllerWithAppRouter:(id<MTAppRouterInterface>)appRouter
                                         delegate:(id<MTEditPlaceDetailDelegate>)delegate;

@end
