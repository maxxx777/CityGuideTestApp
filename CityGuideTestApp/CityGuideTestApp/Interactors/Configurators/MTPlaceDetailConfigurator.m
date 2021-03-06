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
#import "NSString+MTFormatting.h"

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
    if (self.place.latitude && self.place.longitude) {
        return @{
                 @"latitude" : self.place.latitude,
                 @"longitude" : self.place.longitude
                 };
    } else {
        return nil;
    }
}

- (NSURL *)photoURL
{
    return [NSURL URLWithString:self.place.imageUrl];
}

- (NSString *)fileName
{
    return self.place.fileName;
}

- (void)configurePlaceName:(NSString *)name
{
    _place.itemName = name;
    
    for (id<MTPlaceDetailConfiguratorOutputInterface> output in self.outputs) {
        if ([output respondsToSelector:@selector(onDidConfigurePlaceName)]) {
            [output onDidConfigurePlaceName];
        }
    }
}

- (void)configurePlaceDescription:(NSString *)description
{
    _place.placeDescription = description;
    
    for (id<MTPlaceDetailConfiguratorOutputInterface> output in self.outputs) {
        if ([output respondsToSelector:@selector(onDidConfigurePlaceDescription)]) {
            [output onDidConfigurePlaceDescription];
        }
    }
}

- (void)configurePlaceCoordinates:(NSDictionary *)coordinates
{
    _place.latitude = coordinates[@"latitude"];
    _place.longitude = coordinates[@"longitude"];
    
    for (id<MTPlaceDetailConfiguratorOutputInterface> output in self.outputs) {
        if ([output respondsToSelector:@selector(onDidConfigurePlaceCoordinates)]) {
            [output onDidConfigurePlaceCoordinates];
        }
    }
}

- (void)configurePlaceFileName:(NSString *)fileName
{
    _place.fileName = fileName;
    
    for (id<MTPlaceDetailConfiguratorOutputInterface> output in self.outputs) {
        if ([output respondsToSelector:@selector(onDidConfigurePlaceFileName)]) {
            [output onDidConfigurePlaceFileName];
        }
    }
}

- (id)currentItem
{
    return [[MTMappedPlace alloc] initWithItemId:self.place.itemId
                                        itemName:self.place.itemName
                                        latitude:self.place.latitude
                                       longitude:self.place.longitude
                                        imageUrl:self.place.imageUrl
                                        fileName:self.place.fileName
                                placeDescription:self.place.placeDescription
                                            city:self.place.city];
}

- (void)refreshCurrentItem
{
    //
}

@end
