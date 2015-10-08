//
//  MTItemDataManager.m
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 07.10.15.
//  Copyright (c) 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTItemDataManager.h"
#import "MTItemWebService.h"
#import "MTSaveItemsOperation.h"
#import "MTOperationManager.h"
#import "MTArrayBasedItemListCacheInterface.h"
#import "MTFetchedResultsControllerBasedItemListCacheInterface.h"
#import "NSString+MTSpecificStrings.h"
#import "MTDataStore.h"
#import "MTMappedCity.h"

@interface MTItemDataManager ()

@property (nonatomic, strong) MTSaveItemsOperation *saveItemsOperation;
@property (nonatomic, weak) id<MTArrayBasedItemListCacheInterface>cityListCache;
@property (nonatomic, weak) id<MTFetchedResultsControllerBasedItemListCacheInterface>placeListCache;
@property (nonatomic, strong) void(^processItemCompletion)(NSError *, id);

@end

@implementation MTItemDataManager

#pragma mark - MTItemDataManagerInterface

- (void)fetchItemListWithCityListCache:(id<MTArrayBasedItemListCacheInterface>)cityListCache
                        placeListCache:(id<MTFetchedResultsControllerBasedItemListCacheInterface>)placeListCache
                            completion:(MTRootDataManagerCompletionBlock)completionBlock
{
    [self setProcessItemCompletion:completionBlock];
    [self setCityListCache:cityListCache];
    [self setPlaceListCache:placeListCache];
    
    if ([self countOfCities] == 0) {
        [self refreshItemListWithCityListCache:cityListCache
                                placeListCache:placeListCache
                                    completion:self.processItemCompletion];
    } else {
        [self cacheItemListWithCompletion:self.processItemCompletion];
    }
}

- (void)refreshItemListWithCityListCache:(id<MTArrayBasedItemListCacheInterface>)cityListCache
                          placeListCache:(id<MTFetchedResultsControllerBasedItemListCacheInterface>)placeListCache
                              completion:(MTRootDataManagerCompletionBlock)completionBlock
{
    [self setProcessItemCompletion:completionBlock];
    [self setCityListCache:cityListCache];
    [self setPlaceListCache:placeListCache];
    
    [self.itemWebService fetchItemListWithCompletion:^(id data, NSError *error){
        if (data) {
            
            _saveItemsOperation = [[MTSaveItemsOperation alloc] initWithItems:data
                                                                     delegate:self];
            [[MTOperationManager sharedManager] queueOperation:self.saveItemsOperation];
            
        } else {
            if (self.processItemCompletion) {
                self.processItemCompletion(error, nil);
                [self setProcessItemCompletion:nil];
            }
        }
    }];
}

- (void)searchItemsWithSearchString:(NSString *)searchString
                      itemListCache:(id<MTItemListCacheInterface>)itemListCache
                 searchResultsCache:(id<MTArrayBasedItemListCacheInterface>)searchResultsCache
                         completion:(MTRootDataManagerCompletionBlock)completionBlock
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"itemName BEGINSWITH[cd] %@", searchString];
    
    [searchResultsCache cacheItemListWithSourceObjects:[itemListCache allCachedItems]
                                             predicate:predicate
                                            completion:completionBlock];
}

#pragma mark - MTMergeObjectsOperationDelegate

- (void)onDidObjectsMergeWithError:(NSError *)error
              isOperationCancelled:(BOOL)isOperationCancelled
{
    [[NSOperationQueue mainQueue] addOperationWithBlock:^
    {
        [self cacheItemListWithCompletion:self.processItemCompletion];
    }];
    
}

#pragma mark - Helper

- (NSUInteger)countOfCities
{
    return [[MTDataStore sharedStore] countOfObjectsForEntity:@"MTManagedCity"
                                                    predicate:nil
                                            sortedDescriptors:nil
                                                      context:[[MTDataStore sharedStore] mainQueueContext]];
}

- (void)cacheItemListWithCompletion:(MTRootDataManagerCompletionBlock)completionBlock
{
    if (self.placeListCache && [self.placeListCache respondsToSelector:@selector(cacheItemListWithEntityName:sortDescriptors:predicate:sectionNameKeyPath:context:completion:)]) {
        NSSortDescriptor *sd1 = [[NSSortDescriptor alloc] initWithKey:@"city.itemName"
                                                            ascending:YES];
        [self.placeListCache cacheItemListWithEntityName:@"MTManagedPlace"
                                        sortDescriptors:@[sd1]
                                              predicate:nil
                                     sectionNameKeyPath:@"city.itemName"
                                                context:[[MTDataStore sharedStore] mainQueueContext]
                                             completion:^(NSError *error, id fetchedItem){
                                                 
                                                 if (self.cityListCache && [self.cityListCache respondsToSelector:@selector(cacheItemListWithSourceObjects:predicate:completion:)]) {
                                                     NSSortDescriptor *sd1 = [[NSSortDescriptor alloc] initWithKey:@"itemName"
                                                                                                         ascending:YES];
                                                     NSArray *allCities = [[MTDataStore sharedStore] objectsForEntity:@"MTManagedCity"
                                                                                                            predicate:nil
                                                                                                    sortedDescriptors:@[sd1]
                                                                                                              context:[[MTDataStore sharedStore] mainQueueContext]];
                                                     [self.cityListCache cacheItemListWithSourceObjects:allCities
                                                                                              predicate:nil
                                                                                             completion:^(NSError *error, id fetchedItem){
                                                                                                 if (self.processItemCompletion != nil) {
                                                                                                     self.processItemCompletion(error, nil);
                                                                                                     [self setProcessItemCompletion:nil];
                                                                                                 }
                                                     }];
                                                 }
                                                 
                                             }];
    }
}

@end
