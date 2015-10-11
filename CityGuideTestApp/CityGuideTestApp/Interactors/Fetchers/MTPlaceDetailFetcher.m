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

@interface MTPlaceDetailFetcher ()

@property (nonatomic, strong) MTMappedPlace *place;

@end

@implementation MTPlaceDetailFetcher

- (instancetype)initWithPlace:(MTMappedPlace *)place
{
    self = [super init];
    if (self) {
        
        _place = place;
        
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

@end
