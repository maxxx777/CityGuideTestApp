//
//  MTItemListSearcher.h
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 07.10.15.
//  Copyright (c) 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTRootInteractor.h"
#import "MTItemListSearcherIOInterface.h"

@protocol MTArrayBasedItemListCacheInterface;
@protocol MTRootDataManagerInterface;

@interface MTItemListSearcher : MTRootInteractor
<
    MTItemListSearcherInputInterface
>

- (instancetype)initWithSearchResultsCache:(id<MTArrayBasedItemListCacheInterface>)searchResultsCache
                           rootDataManager:(id<MTRootDataManagerInterface>)rootDataManager NS_DESIGNATED_INITIALIZER;

@end
