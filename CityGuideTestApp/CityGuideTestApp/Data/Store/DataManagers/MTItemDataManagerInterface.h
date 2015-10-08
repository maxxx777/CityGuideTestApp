//
//  MTItemDataManagerInterface.h
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 07.10.15.
//  Copyright (c) 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTRootDataManagerInterface.h"

@protocol MTFetchedResultsControllerBasedItemListCacheInterface;

@protocol MTItemDataManagerInterface <NSObject, MTRootDataManagerInterface>

- (void)fetchItemListWithCityListCache:(id<MTArrayBasedItemListCacheInterface>)cityListCache
                        placeListCache:(id<MTFetchedResultsControllerBasedItemListCacheInterface>)placeListCache
                            completion:(MTRootDataManagerCompletionBlock)completionBlock;
- (void)refreshItemListWithCityListCache:(id<MTArrayBasedItemListCacheInterface>)cityListCache
                          placeListCache:(id<MTFetchedResultsControllerBasedItemListCacheInterface>)placeListCache
                              completion:(MTRootDataManagerCompletionBlock)completionBlock;

@end
