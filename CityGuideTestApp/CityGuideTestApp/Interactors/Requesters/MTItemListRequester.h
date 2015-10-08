//
//  MTItemListRequester.h
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 07.10.15.
//  Copyright (c) 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTRootInteractor.h"
#import "MTItemListRequesterIOInterface.h"

@protocol MTFetchedResultsControllerBasedItemListCacheInterface;
@protocol MTArrayBasedItemListCacheInterface;
@protocol MTItemDataManagerInterface;

@interface MTItemListRequester : MTRootInteractor
<
    MTItemListRequesterInputInterface
>

- (instancetype)initWithCityListCache:(id<MTArrayBasedItemListCacheInterface>)cityListCache
                       placeListCache:(id<MTFetchedResultsControllerBasedItemListCacheInterface>)placeListCache
                      itemDataManager:(id<MTItemDataManagerInterface>)itemDataManager NS_DESIGNATED_INITIALIZER;

@end
