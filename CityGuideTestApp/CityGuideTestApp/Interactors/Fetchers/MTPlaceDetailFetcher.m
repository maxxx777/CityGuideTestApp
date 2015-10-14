//
//  MTPlaceDetailFetcher.m
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 10.10.15.
//  Copyright © 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTPlaceDetailFetcher.h"
#import "MTMappedPlace.h"
#import "MTMappedCity.h"
#import "MTItemDataManagerInterface.h"

@interface MTPlaceDetailFetcher ()

@property (nonatomic, strong) MTMappedPlace *place;
@property (nonatomic, strong) id<MTItemDataManagerInterface>itemDataManager;

@end

@implementation MTPlaceDetailFetcher

- (instancetype)initWithPlace:(MTMappedPlace *)place
              itemDataManager:(id<MTItemDataManagerInterface>)itemDataManager
{
    self = [super init];
    if (self) {
        
        _place = place;
        _itemDataManager = itemDataManager;
        
    }
    return self;
}

#pragma mark - MTPlaceDetailFetcherInputInterface

- (NSString *)placeName
{
    return self.place.itemName;
}

- (NSString *)cityName
{
    return self.place.city.itemName;
}

- (NSString *)placeDescription
{
    return self.place.placeDescription;
}

- (NSDictionary *)placeCoordinates
{
    return @{
             @"latitude" : self.place.latitude,
             @"longitude" : self.place.longitude
             };
}

- (NSURL *)photoURL
{
    return [NSURL URLWithString:self.place.imageUrl];
}

- (NSString *)fileName
{
    return self.place.fileName;
}

- (id)currentItem
{
    return self.place;
}

- (void)refreshCurrentItem
{
    [self.itemDataManager fetchItemWithItemId:self.place.itemId
                                   completion:^(NSError *error, id fetchedItem){
                                       _place = fetchedItem;
                                       
                                       for (id<MTPlaceDetailFetcherOutputInterface> output in self.outputs) {
                                           if ([output respondsToSelector:@selector(onDidRefreshCurrentItem)]) {
                                               [output onDidRefreshCurrentItem];
                                           }
                                       }
    }];
}

@end
