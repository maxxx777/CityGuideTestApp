//
//  MTItemListFetcher.h
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 07.10.15.
//  Copyright (c) 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTRootInteractor.h"
#import "MTItemListFetcherIOInterface.h"

@protocol MTItemListCacheInterface;
@protocol MTRootDataManagerInterface;

@interface MTItemListFetcher : MTRootInteractor
<
    MTItemListFetcherInputInterface
>

- (instancetype) __unavailable init;
- (instancetype)initWithItemListCache:(id<MTItemListCacheInterface>)itemListCache
                      rootDataManager:(id<MTRootDataManagerInterface>)rootDataManager NS_DESIGNATED_INITIALIZER;

@end
