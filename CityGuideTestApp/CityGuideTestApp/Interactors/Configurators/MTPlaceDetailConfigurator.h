//
//  MTPlaceConfigurator.h
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 11.10.15.
//  Copyright © 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTRootInteractor.h"
#import "MTPlaceDetailConfiguratorIOInterface.h"

@class MTMappedPlace;

@interface MTPlaceDetailConfigurator : MTRootInteractor
<
    MTPlaceDetailConfiguratorInputInterface
>

- (instancetype)initWithNewItem NS_DESIGNATED_INITIALIZER;;

@end
