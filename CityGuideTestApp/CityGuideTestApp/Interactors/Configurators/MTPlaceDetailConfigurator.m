//
//  MTPlaceConfigurator.m
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 11.10.15.
//  Copyright © 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTPlaceDetailConfigurator.h"
#import "MTMutablePlace.h"
#import "MTMappedCity.h"

@interface MTPlaceDetailConfigurator ()

@property (nonatomic, strong) MTMutablePlace *place;

@end

@implementation MTPlaceDetailConfigurator

- (instancetype)initWithNewItem
{
    self = [super init];
    if (self) {
    
        _place = [[MTMutablePlace alloc] init];
        
    }
    return self;
}

#pragma mark - MTPlaceDetailConfiguratorInputInterface

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
