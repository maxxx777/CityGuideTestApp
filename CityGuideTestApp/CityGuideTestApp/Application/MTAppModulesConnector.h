//
//  MTAppModulesConnector.h
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 07.10.15.
//  Copyright (c) 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTAppModulesConnectorInterface.h"

@interface MTAppModulesConnector : NSObject
<
    MTAppModulesConnectorInterface
>

- (instancetype) __unavailable init;
- (instancetype)initWithWindow:(UIWindow *)window NS_DESIGNATED_INITIALIZER;

@end
