//
//  MTItemDataManagerInterface.h
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 07.10.15.
//  Copyright (c) 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTRootDataManagerInterface.h"
#import "MTItemDataManagerFilterTypeConstants.h"

@protocol MTFetchedResultsControllerBasedItemListCacheInterface;
@protocol MTArrayBasedItemListCacheInterface;

@protocol MTItemDataManagerInterface <NSObject, MTRootDataManagerInterface>

- (void)fetchItemListWithFilterType:(MTItemListFilterType)filterType
                      cityListCache:(id<MTArrayBasedItemListCacheInterface> _Nonnull)cityListCache
                     placeListCache:(id<MTFetchedResultsControllerBasedItemListCacheInterface> _Nonnull)placeListCache
                         completion:(MTRootDataManagerCompletionBlock _Nonnull)completionBlock;
- (void)saveItem:(id _Nonnull)item
      completion:(MTRootDataManagerCompletionBlock _Nonnull)completionBlock;
- (void)fetchItemWithItemId:(NSNumber * _Nonnull)itemId
                 completion:(MTRootDataManagerCompletionBlock _Nonnull)completionBlock;

@end
