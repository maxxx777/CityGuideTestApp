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

- (instancetype) __unavailable init;
- (instancetype)initWithPlace:(MTMappedPlace * _Nonnull)place
              itemDataManager:(id<MTItemDataManagerInterface> _Nonnull)itemDataManager NS_DESIGNATED_INITIALIZER;

@end
