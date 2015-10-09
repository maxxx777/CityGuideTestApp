//
//  MTWebServiceParser.m
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 07.10.15.
//  Copyright (c) 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTWebServiceParser.h"
#import "MTMappedCity.h"
#import "MTMappedPlace.h"
#import "NSNumber+MTNewItemId.h"

@implementation MTWebServiceParser

#pragma mark - MTWebServiceParserInterface

- (id)parseItemListFromRawData:(id)rawData
{
    id result;
    
    if ([rawData isKindOfClass:[NSDictionary class]]) {
        
        NSMutableArray *parsedCities = [[NSMutableArray alloc] init];
        
        NSArray *rawArray = rawData[@"places"];
        for (id rawObject in rawArray) {
            
            id newCity = [self parseCityFromRawData:rawObject
                                   withParsedCities:parsedCities];
            if (newCity) {
                [parsedCities addObject:newCity];
            }
            
        }
        
        [self parsePlacesFromRawData:rawData
                    withParsedCities:parsedCities];
        
        result = [NSArray arrayWithArray:parsedCities];
    }
    
    return result;
}

#pragma mark - Private

- (id)parseCityFromRawData:(id)rawData
          withParsedCities:(NSArray *)parsedCities
{
    id result;
    
    if ([rawData isKindOfClass:[NSDictionary class]]) {
        
        NSNumber *itemId;
        NSString *itemName;
        
        itemId = [NSNumber mt_newItemId];
        itemName = rawData[@"city"] ? rawData[@"city"] : NSLocalizedString(@"Unknown City", nil);
        
        NSArray *citiesArray = [parsedCities filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"itemName LIKE %@", itemName]];
        if ([citiesArray count] == 0) {
            result = [[MTMappedCity alloc] initWithItemId:itemId
                                                 itemName:itemName
                                                   places:nil];
        }
        
    }
    
    return result;
}

- (id)parsePlaceFromRawData:(id)rawData
{
    id result;
    
    if ([rawData isKindOfClass:[NSDictionary class]]) {
        
        NSNumber *itemId;
        NSString *itemName;
        NSNumber *latitude;
        NSNumber *longitude;
        NSString *imageUrl;
        NSString *placeDescription;
        
        itemId = [NSNumber mt_newItemId];
        itemName = rawData[@"name"] ? rawData[@"name"] : @"";
        latitude = rawData[@"latitude"] ? rawData[@"latitude"] : @0;
        longitude = rawData[@"longtitude"] ? rawData[@"longtitude"] : @0;
        imageUrl = rawData[@"image"] ? rawData[@"image"] : @"";
        placeDescription = rawData[@"description"] ? rawData[@"description"] : @"";
        
        result = [[MTMappedPlace alloc] initWithItemId:itemId
                                              itemName:itemName
                                              latitude:latitude
                                             longitude:longitude
                                              imageUrl:imageUrl
                                      placeDescription:placeDescription
                                                  city:nil];
    }
    
    return result;
}

- (void)parsePlacesFromRawData:(id)rawData
              withParsedCities:(NSMutableArray *)parsedCities
{
    NSArray *rawArray = rawData[@"places"];
    for (id rawObject in rawArray) {
        
        id place = [self parsePlaceFromRawData:rawObject];

        NSString *cityName = rawObject[@"city"] ? rawObject[@"city"] : NSLocalizedString(@"Unknown City", nil);
        NSArray *citiesArray = [parsedCities filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"itemName LIKE %@", cityName]];
        if ([citiesArray count] > 0) {
            MTMappedCity *city = [citiesArray lastObject];
            NSUInteger cityIndex = [parsedCities indexOfObject:city];
            
            NSMutableArray *cityPlaces;
            if (city.places) {
                cityPlaces = [[NSMutableArray alloc] initWithArray:city.places];
            } else {
                cityPlaces = [NSMutableArray array];
            }
            [cityPlaces addObject:place];
            
            city = [[MTMappedCity alloc] initWithItemId:city.itemId
                                               itemName:city.itemName
                                                 places:cityPlaces];
            
            [parsedCities replaceObjectAtIndex:cityIndex
                                    withObject:city];
        }
    }
}

@end
