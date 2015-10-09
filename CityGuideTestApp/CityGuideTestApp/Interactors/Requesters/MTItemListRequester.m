//
//  MTItemListRequester.m
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 07.10.15.
//  Copyright (c) 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTItemListRequester.h"
#import "MTFetchedResultsControllerBasedItemListCacheInterface.h"
#import "MTArrayBasedItemListCacheInterface.h"
#import "MTItemDataManagerInterface.h"

@interface MTItemListRequester ()

@property (nonatomic, strong) id<MTArrayBasedItemListCacheInterface>cityListCache;
@property (nonatomic, strong) id<MTFetchedResultsControllerBasedItemListCacheInterface>placeListCache;
@property (nonatomic, strong) id<MTItemDataManagerInterface>itemDataManager;

@end

@implementation MTItemListRequester

- (instancetype)initWithCityListCache:(id<MTArrayBasedItemListCacheInterface>)cityListCache
                       placeListCache:(id<MTFetchedResultsControllerBasedItemListCacheInterface>)placeListCache
                      itemDataManager:(id<MTItemDataManagerInterface>)itemDataManager
{
    self = [super init];
    if (self) {
        
        _cityListCache = cityListCache;
        _placeListCache = placeListCache;
        _itemDataManager = itemDataManager;
        
    }
    return self;
}

- (void)fetchAllItems
{
    [self.itemDataManager fetchItemListWithFilterType:MTItemListFilterTypeAll
                                        cityListCache:self.cityListCache
                                       placeListCache:self.placeListCache
                                           completion:^(NSError *error, id fetchedItem){
        for (id<MTItemListRequesterOutputInterface> output in self.outputs) {
            if ([output respondsToSelector:@selector(onDidFetchItemsWithError:)]) {
                [output onDidFetchItemsWithError:error];
            }
        }
                                              }];
}

- (void)fetchItemsWithin1Mile
{
    [self.itemDataManager fetchItemListWithFilterType:MTItemListFilterType1Mile
                                        cityListCache:self.cityListCache
                                       placeListCache:self.placeListCache
                                           completion:^(NSError *error, id fetchedItem){
                                               for (id<MTItemListRequesterOutputInterface> output in self.outputs) {
                                                   if ([output respondsToSelector:@selector(onDidFetchItemsWithError:)]) {
                                                       [output onDidFetchItemsWithError:error];
                                                   }
                                               }
                                           }];
}

- (void)fetchItemsWithin10Mile
{
    [self.itemDataManager fetchItemListWithFilterType:MTItemListFilterType10Mile
                                        cityListCache:self.cityListCache
                                       placeListCache:self.placeListCache
                                           completion:^(NSError *error, id fetchedItem){
                                               for (id<MTItemListRequesterOutputInterface> output in self.outputs) {
                                                   if ([output respondsToSelector:@selector(onDidFetchItemsWithError:)]) {
                                                       [output onDidFetchItemsWithError:error];
                                                   }
                                               }
                                           }];
}

- (void)fetchItemsWithin100Mile
{
    [self.itemDataManager fetchItemListWithFilterType:MTItemListFilterType100Mile
                                        cityListCache:self.cityListCache
                                       placeListCache:self.placeListCache
                                           completion:^(NSError *error, id fetchedItem){
                                               for (id<MTItemListRequesterOutputInterface> output in self.outputs) {
                                                   if ([output respondsToSelector:@selector(onDidFetchItemsWithError:)]) {
                                                       [output onDidFetchItemsWithError:error];
                                                   }
                                               }
                                           }];
}

@end
