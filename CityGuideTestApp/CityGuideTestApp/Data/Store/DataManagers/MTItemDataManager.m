//
//  MTItemDataManager.m
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 07.10.15.
//  Copyright (c) 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTItemDataManager.h"
#import "MTItemWebService.h"
#import "MTSavePlaceOperation.h"
#import "MTSaveItemsOperation.h"
#import "MTArrayBasedItemListCacheInterface.h"
#import "MTFetchedResultsControllerBasedItemListCacheInterface.h"
#import "MTDataMapping.h"
#import "MTDataStore.h"
#import "NSString+MTSpecificStrings.h"
#import "MTMappedCity.h"
#import "MTMappedPlace.h"
#import "MTLocationManager.h"
#import "MTOperationManager.h"

@interface MTItemDataManager ()

@property (nonatomic) MTItemListFilterType filterType;
@property (nonatomic, strong) MTSavePlaceOperation *savePlaceOperation;
@property (nonatomic, strong) MTSaveItemsOperation *saveItemsOperation;
@property (nonatomic, weak) id<MTArrayBasedItemListCacheInterface>cityListCache;
@property (nonatomic, weak) id<MTFetchedResultsControllerBasedItemListCacheInterface>placeListCache;
@property (nonatomic, strong) void(^processItemCompletion)(NSError *, id);

@end

@implementation MTItemDataManager

#pragma mark - MTItemDataManagerInterface

- (void)fetchItemListWithFilterType:(MTItemListFilterType)filterType
                      cityListCache:(id<MTArrayBasedItemListCacheInterface>)cityListCache
                     placeListCache:(id<MTFetchedResultsControllerBasedItemListCacheInterface>)placeListCache
                         completion:(MTRootDataManagerCompletionBlock)completionBlock
{
    self.filterType = filterType;
    self.processItemCompletion = completionBlock;
    self.cityListCache = cityListCache;
    self.placeListCache = placeListCache;
    
    if ([self countOfCities] == 0) {
        [self refreshItemListWithCityListCache:cityListCache
                                placeListCache:placeListCache
                                    completion:self.processItemCompletion];
    } else {
        [self cacheItemListWithCompletion:self.processItemCompletion];
    }
}

- (void)saveItem:(id)item
      completion:(MTRootDataManagerCompletionBlock)completionBlock
{
    self.processItemCompletion = completionBlock;
    
    _savePlaceOperation = [[MTSavePlaceOperation alloc] initWithPlace:item
                                               mergeOperationDelegate:self];
    [[MTOperationManager sharedManager] queueOperation:self.savePlaceOperation];
}

- (void)fetchItemWithItemId:(NSNumber *)itemId
                 completion:(MTRootDataManagerCompletionBlock)completionBlock
{
    self.processItemCompletion = completionBlock;
    
    NSManagedObject *managedPlace = [[MTDataStore sharedStore] objectForEntity:@"MTManagedPlace"
                                                                     predicate:[NSPredicate predicateWithFormat:@"itemId == %@", itemId]
                                                             sortedDescriptors:nil
                                                                       context:[MTDataStore sharedStore].mainQueueContext];
    MTDataMapping *dataMapping = [[MTDataMapping alloc] init];
    id mappedPlace = [dataMapping mappedObjectFromManagedObject:managedPlace];
    
    if (self.processItemCompletion) {
        self.processItemCompletion(nil, mappedPlace);
        [self setProcessItemCompletion:nil];
    }
}

#pragma mark - MTMergeObjectsOperationDelegate

- (void)onDidObjectsMergeWithError:(NSError *)error
              isOperationCancelled:(BOOL)isOperationCancelled
{
    [self cacheItemListWithCompletion:self.processItemCompletion];
}

- (void)onDidObjectMergeWithError:(NSError *)error
                           object:(id)object
             isOperationCancelled:(BOOL)isOperationCancelled
{
    self.processItemCompletion(error, nil);
}

#pragma mark - Helper

- (NSUInteger)countOfCities
{
    return [[MTDataStore sharedStore] countOfObjectsForEntity:@"MTManagedCity"
                                                    predicate:nil
                                            sortedDescriptors:nil
                                                      context:[MTDataStore sharedStore].mainQueueContext];
}

- (void)refreshItemListWithCityListCache:(id<MTArrayBasedItemListCacheInterface>)cityListCache
                          placeListCache:(id<MTFetchedResultsControllerBasedItemListCacheInterface>)placeListCache
                              completion:(MTRootDataManagerCompletionBlock)completionBlock
{
    self.processItemCompletion = completionBlock;
    self.cityListCache = cityListCache;
    self.placeListCache = placeListCache;
    
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

- (void)cacheItemListWithCompletion:(MTRootDataManagerCompletionBlock)completionBlock
{
    if (self.placeListCache && [self.placeListCache respondsToSelector:@selector(cacheItemListWithEntityName:sortDescriptors:predicate:sectionNameKeyPath:context:completion:)]) {
        
        
        NSSortDescriptor *sd1 = [[NSSortDescriptor alloc] initWithKey:@"city.itemName"
                                                            ascending:YES];
        NSSortDescriptor *sd2 = [[NSSortDescriptor alloc] initWithKey:@"itemName"
                                                            ascending:YES];
        [self.placeListCache cacheItemListWithEntityName:@"MTManagedPlace"
                                         sortDescriptors:@[sd1, sd2]
                                               predicate:[self predicateForFilterType:self.filterType]
                                      sectionNameKeyPath:@"city.itemName"
                                                 context:[MTDataStore sharedStore].mainQueueContext
                                              completion:^(NSError *error, id fetchedItem){
                                                  
                                                  if (self.cityListCache && [self.cityListCache respondsToSelector:@selector(cacheItemListWithSourceObjects:predicate:completion:)]) {
                                                      NSSortDescriptor *sd1 = [[NSSortDescriptor alloc] initWithKey:@"itemName"
                                                                                                          ascending:YES];
                                                      
                                                      NSArray *allCities = [[MTDataStore sharedStore] objectsForEntity:@"MTManagedCity"
                                                                                                             predicate:[NSPredicate predicateWithFormat:@"SUBQUERY(places, $x, $x IN %@).@count > 0", [self.placeListCache allCachedItems]]
                                                                                                     sortedDescriptors:@[sd1]
                                                                                                               context:[MTDataStore sharedStore].mainQueueContext];
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

- (NSPredicate *)predicateForFilterType:(MTItemListFilterType)filterType
{
    NSPredicate* p;
    switch (filterType) {
        case MTItemListFilterTypeAll:
        {
            p = [NSPredicate predicateWithValue:YES];
        }
            break;
        case MTItemListFilterType1Mile:
        {
            NSSet *idsOfPlaces = [self idsOfPlacesWithinRadius:@(1000)];
            p = [NSPredicate predicateWithFormat:@"itemId IN %@", idsOfPlaces];
        }
            break;
        case MTItemListFilterType10Mile:
        {
            NSSet *idsOfPlaces = [self idsOfPlacesWithinRadius:@(10000)];
            p = [NSPredicate predicateWithFormat:@"itemId IN %@", idsOfPlaces];
        }
            break;
        case MTItemListFilterType100Mile:
        {
            NSSet *idsOfPlaces = [self idsOfPlacesWithinRadius:@(100000)];
            p = [NSPredicate predicateWithFormat:@"itemId IN %@", idsOfPlaces];
        }
            break;
    }
    return p;
}

- (NSSet *)idsOfPlacesWithinRadius:(NSNumber *)radius
{
    NSMutableSet *result = [NSMutableSet set];
    MTDataMapping *dataMapping = [[MTDataMapping alloc] init];
    
    NSArray *places = [[MTDataStore sharedStore] objectsForEntity:@"MTManagedPlace"
                                                        predicate:nil
                                                sortedDescriptors:nil
                                                          context:[MTDataStore sharedStore].mainQueueContext];
    for (NSManagedObject *managedPlace in places) {
        
        MTMappedPlace *mappedPlace = [dataMapping mappedObjectFromManagedObject:managedPlace];
        BOOL isPlaceWithinRadius = [[MTLocationManager sharedManager]
                                    isLocationWithLatitude:mappedPlace.latitude
                                    longitude:mappedPlace.longitude
                                    withinRadius:radius];
        if (isPlaceWithinRadius) {
            [result addObject:mappedPlace.itemId];
        }
    }
    
    return result;
}

@end
