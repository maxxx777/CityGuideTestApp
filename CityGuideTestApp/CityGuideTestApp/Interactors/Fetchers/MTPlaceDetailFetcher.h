//
//  MTPlaceDetailFetcher.h
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 10.10.15.
//  Copyright © 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTRootInteractor.h"
#import "MTPlaceDetailFetcherIOInterface.h"

@class MTMappedPlace;

@protocol MTItemDataManagerInterface;

@interface MTPlaceDetailFetcher : MTRootInteractor
<
    MTPlaceDetailFetcherInputInterface
>

- (instancetype)initWithPlace:(MTMappedPlace *)place
              itemDataManager:(id<MTItemDataManagerInterface>)itemDataManager NS_DESIGNATED_INITIALIZER;

@end
