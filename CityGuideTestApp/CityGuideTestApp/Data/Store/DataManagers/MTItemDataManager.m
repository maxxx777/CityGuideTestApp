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
#import "MTMappedPlace.h"
#import "MTLocationManager.h"
#import "MTDataMapping.h"

@interface MTItemDataManager ()

@property (nonatomic) MTItemListFilterType filterType;
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
    [self setFilterType:filterType];
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
        
        NSDictionary *currentLocation = [[NSUserDefaults standardUserDefaults] objectForKey:@"MTSettingsCurrentLocation"];
        BOOL isFilterWithLocationUse = self.filterType == MTItemListFilterType1Mile || self.filterType == MTItemListFilterType10Mile || self.filterType ==  MTItemListFilterType100Mile;
        if (isFilterWithLocationUse && currentLocation == nil) {
            completionBlock(nil, nil);
        } else {
         
            NSSortDescriptor *sd1 = [[NSSortDescriptor alloc] initWithKey:@"city.itemName"
                                                                ascending:YES];
            [self.placeListCache cacheItemListWithEntityName:@"MTManagedPlace"
                                             sortDescriptors:@[sd1]
                                                   predicate:[self predicateForFilterType:self.filterType]
                                          sectionNameKeyPath:@"city.itemName"
                                                     context:[[MTDataStore sharedStore] mainQueueContext]
                                                  completion:^(NSError *error, id fetchedItem){
                                                      
                                                      if (self.cityListCache && [self.cityListCache respondsToSelector:@selector(cacheItemListWithSourceObjects:predicate:completion:)]) {
                                                          NSSortDescriptor *sd1 = [[NSSortDescriptor alloc] initWithKey:@"itemName"
                                                                                                              ascending:YES];
                                                          
                                                          NSArray *allCities = [[MTDataStore sharedStore] objectsForEntity:@"MTManagedCity"
                                                                                                                 predicate:[NSPredicate predicateWithFormat:@"SUBQUERY(places, $x, $x IN %@).@count > 0", [self.placeListCache allCachedItems]]
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
                                                          context:[[MTDataStore sharedStore] mainQueueContext]];
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

//- (NSPredicate *)predicateWithMileValue:(NSNumber *)mileValue
//{
//    NSPredicate *result;
//
//    NSDictionary *currentLocation = [[NSUserDefaults standardUserDefaults] objectForKey:@"MTSettingsCurrentLocation"];
//    if (currentLocation) {
//        [NSPredicate predicateWithFormat:@""]
//    }
//    return result;
//}

@end
