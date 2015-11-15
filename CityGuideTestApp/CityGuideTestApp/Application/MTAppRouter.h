//
//  MTAppRouter.h
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 14.11.15.
//  Copyright © 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTAppRouterInterface.h"

@protocol MTItemListAssemblyInterface;
@protocol MTShowPlaceDetailAssemblyInterface;
@protocol MTAddNewPlaceAssemblyInterface;
@protocol MTImageBrowserAssemblyInterface;

@interface MTAppRouter : NSObject
<
    MTAppRouterInterface
>

@property (nonatomic, strong) id<MTItemListAssemblyInterface>itemListAssembly;
@property (nonatomic, strong) id<MTShowPlaceDetailAssemblyInterface>showPlaceDetailAssembly;
@property (nonatomic, strong) id<MTAddNewPlaceAssemblyInterface>addNewPlaceAssembly;
@property (nonatomic, strong) id<MTImageBrowserAssemblyInterface>imageBrowserAssembly;

@end
