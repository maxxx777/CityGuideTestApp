//
//  MTItemListExpander.h
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 08.10.15.
//  Copyright © 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTRootInteractor.h"
#import "MTItemListExpanderIOInterface.h"

@protocol MTFetchedResultsControllerBasedItemListCacheInterface;
@protocol MTArrayBasedItemListCacheInterface;
@protocol MTItemDataManagerInterface;

@interface MTItemListExpander : MTRootInteractor
<
    MTItemListExpanderInputInterface
>

- (instancetype) __unavailable init;
- (instancetype)initWithCityListCache:(id<MTArrayBasedItemListCacheInterface> _Nonnull)cityListCache
                       placeListCache:(id<MTFetchedResultsControllerBasedItemListCacheInterface> _Nonnull)placeListCache
                      itemDataManager:(id<MTItemDataManagerInterface> _Nonnull)itemDataManager NS_DESIGNATED_INITIALIZER;

@end
