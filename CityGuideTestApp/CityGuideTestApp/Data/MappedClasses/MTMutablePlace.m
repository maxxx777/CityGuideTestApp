//
//  MTMutablePlace.m
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 11.10.15.
//  Copyright © 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTMutablePlace.h"
#import "NSNumber+MTNewItemId.h"

@implementation MTMutablePlace
@dynamic itemName;
@dynamic placeDescription;
@dynamic latitude;
@dynamic longitude;
@dynamic imageUrl;

- (instancetype)initWithPlace:(MTMappedPlace *)place_
{
    self = [super initWithItemId:place_.itemId
                        itemName:place_.itemName
                        latitude:place_.latitude
                       longitude:place_.longitude
                        imageUrl:place_.imageUrl
                placeDescription:place_.placeDescription
                            city:nil];
    if (self) {
        self.itemName = place_.itemName;
        self.placeDescription = place_.placeDescription;
        self.latitude = place_.latitude;
        self.longitude = place_.longitude;
        self.imageUrl = place_.imageUrl;
    }
    return self;
}

- (instancetype)initWithItemId:(NSNumber *)itemId_
                      itemName:(NSString *)itemName_
                      latitude:(NSNumber *)latitude_
                     longitude:(NSNumber *)longitude_
                      imageUrl:(NSString *)imageUrl_
              placeDescription:(NSString *)placeDescription_
                          city:(MTMappedCity *)city_
{
    return [self initWithPlace:nil];
}

- (instancetype)init
{
    NSNumber *newItemId = [NSNumber mt_newItemId];
    MTMappedPlace *mappedPlace = [[MTMappedPlace alloc] initWithItemId:newItemId
                                                              itemName:nil
                                                              latitude:nil
                                                             longitude:nil
                                                              imageUrl:nil
                                                      placeDescription:nil
                                                                  city:nil];
    return [self initWithPlace:mappedPlace];
}

- (void)setItemName:(NSString *)itemName
{
    _itemName = [itemName mutableCopy];
}

- (void)setPlaceDescription:(NSString *)placeDescription
{
    _placeDescription = [placeDescription copy];
}

- (void)setLatitude:(NSNumber *)latitude
{
    _latitude = [latitude copy];
}

- (void)setLongitude:(NSNumber *)longitude
{
    _longitude = [longitude copy];
}

- (void)setImageUrl:(NSString *)imageUrl
{
    _imageUrl = [imageUrl copy];
}

@end
