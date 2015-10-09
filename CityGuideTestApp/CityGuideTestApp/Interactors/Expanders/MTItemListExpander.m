//
//  MTItemListExpander.m
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 08.10.15.
//  Copyright © 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTItemListExpander.h"
#import "MTFetchedResultsControllerBasedItemListCacheInterface.h"
#import "MTArrayBasedItemListCacheInterface.h"
#import "MTItemDataManagerInterface.h"
#import "MTMappedCity.h"

@interface MTItemListExpander ()

@property (nonatomic, strong) id<MTArrayBasedItemListCacheInterface>cityListCache;
@property (nonatomic, strong) id<MTFetchedResultsControllerBasedItemListCacheInterface>placeListCache;
@property (nonatomic, strong) id<MTItemDataManagerInterface>itemDataManager;
@property (nonatomic, strong) NSMutableArray *openedCities;

@end

@implementation MTItemListExpander

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

- (NSMutableArray *)openedCities
{
    if (_openedCities) {
        return _openedCities;
    }
    
    _openedCities = [NSMutableArray array];
    for (int i = 0; i < [self.cityListCache numberOfAllCachedItems]; i++) {
        [self.openedCities addObject:@0];
    }
    
    return _openedCities;
}

#pragma mark - MTItemListExpanderInputInterface

- (NSUInteger)numberOfRows
{
    NSUInteger result = [self.openedCities count];
    for (NSUInteger i = 0; i < [self.openedCities count]; i++) {
        if ([self.openedCities objectAtIndex:i]) {
            result += [[self.openedCities objectAtIndex:i] integerValue];
        }
    }
    return result;
}

- (id)objectAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger cityIndex = [self cityIndexForIndexPath:indexPath];
    NSInteger placeIndex = [self placeIndexForIndexPath:indexPath];
    
    id mappedObject;
    if ([self isCityObjectAtIndexPath:indexPath]) {
        mappedObject = [self.itemDataManager mappedObjectAtIndexPath:[NSIndexPath indexPathForRow:cityIndex
                                                                                        inSection:0]
                                                       itemListCache:self.cityListCache];
    } else {
        mappedObject = [self.itemDataManager mappedObjectAtIndexPath:[NSIndexPath indexPathForRow:placeIndex
                                                                                        inSection:cityIndex]
                                                       itemListCache:self.placeListCache];
    }
    return mappedObject;
}

- (BOOL)isCityObjectAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *cityAndPlaceIndexes = [self cityAndPlaceIndexesForIndexPath:indexPath];

    return [cityAndPlaceIndexes[@"placeIndex"] isEqualToNumber:@(-1)];
}

- (BOOL)isOpenedCityAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger cityIndex = [self cityIndexForIndexPath:indexPath];
    return [self.openedCities objectAtIndex:cityIndex] && ![[self.openedCities objectAtIndex:cityIndex] isEqualToNumber:@0];
}

- (void)openOrCloseCityAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger cityIndex = [self cityIndexForIndexPath:indexPath];
    if ([self.openedCities objectAtIndex:cityIndex] && ![[self.openedCities objectAtIndex:cityIndex] isEqualToNumber:@0]) {
        
        NSMutableArray *indexPathsToClose = [NSMutableArray array];
        for (NSInteger i = 0; i < [[self.openedCities objectAtIndex:cityIndex] integerValue]; i++) {
            NSIndexPath *indexPathToClose = [NSIndexPath indexPathForRow:i + indexPath.row + 1
                                                               inSection:0];
            [indexPathsToClose addObject:indexPathToClose];
        }
        
        [self.openedCities replaceObjectAtIndex:cityIndex
                                     withObject:@0];
        
        for (id<MTItemListExpanderOutputInterface> output in self.outputs) {
            if ([output respondsToSelector:@selector(onDidCloseCityPlacesAtIndexPaths:)]) {
                [output onDidCloseCityPlacesAtIndexPaths:indexPathsToClose];
            }
        }
        
    } else {
        
        NSMutableArray *indexPathsToOpen = [NSMutableArray array];
        for (NSInteger i = 0; i < [self.placeListCache numberOfRowsInSection:cityIndex]; i++) {
            NSIndexPath *indexPathToOpen = [NSIndexPath indexPathForRow:i + indexPath.row + 1
                                                               inSection:0];
            [indexPathsToOpen addObject:indexPathToOpen];
        }
        
        [self.openedCities replaceObjectAtIndex:cityIndex
                                      withObject:@([self.placeListCache numberOfRowsInSection:cityIndex])];
        
        for (id<MTItemListExpanderOutputInterface> output in self.outputs) {
            if ([output respondsToSelector:@selector(onDidOpenCityPlacesAtIndexPaths:)]) {
                [output onDidOpenCityPlacesAtIndexPaths:indexPathsToOpen];
            }
        }
    }
}

#pragma mark - Helper

- (NSInteger)cityIndexForIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *cityAndPlaceIndexes = [self cityAndPlaceIndexesForIndexPath:indexPath];
    
    return [cityAndPlaceIndexes[@"cityIndex"] integerValue];
}

- (NSInteger)placeIndexForIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *cityAndPlaceIndexes = [self cityAndPlaceIndexesForIndexPath:indexPath];
    
    return [cityAndPlaceIndexes[@"placeIndex"] integerValue];
}

- (NSDictionary *)cityAndPlaceIndexesForIndexPath:(NSIndexPath *)indexPath
{
    NSInteger cityIndex = 0;
    NSInteger placeIndex = -1;
    NSInteger totalIndex = 0;
    
    while (indexPath.row > totalIndex) {
        
        //if city is open
        if ([self.openedCities objectAtIndex:cityIndex] && ![[self.openedCities objectAtIndex:cityIndex] isEqualToNumber:@0]) {
            
            NSInteger placeCountForCity = [[self.openedCities objectAtIndex:cityIndex] integerValue];

            //if index path is more than opened city
            if (indexPath.row - totalIndex > placeCountForCity) {
                
                totalIndex += placeCountForCity;
                placeIndex = -1;
                
            } else {
               
                placeIndex = indexPath.row - totalIndex - 1;
                totalIndex += indexPath.row - totalIndex;
                
            }
            
        }
        
        if (indexPath.row > totalIndex) {
            totalIndex++; //add one city
            cityIndex++;
        }
    }
    
    return @{
             @"cityIndex" : @(cityIndex),
             @"placeIndex" : @(placeIndex),
             };
}

@end
