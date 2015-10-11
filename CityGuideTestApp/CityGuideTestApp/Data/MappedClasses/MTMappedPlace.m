//
//  MTMappedPlace.m
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 08.10.15.
//  Copyright (c) 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTMappedPlace.h"
#import "MTMappedCity.h"
#import "MTMutablePlace.h"

@interface MTMappedPlace ()

@end

@implementation MTMappedPlace
@synthesize itemName = _itemName;
@synthesize latitude = _latitude;
@synthesize longitude = _longitude;
@synthesize placeDescription = _placeDescription;
@synthesize imageUrl = _imageUrl;

- (instancetype)initWithItemId:(NSNumber *)itemId_
                      itemName:(NSString *)itemName_
                      latitude:(NSNumber *)latitude_
                     longitude:(NSNumber *)longitude_
                      imageUrl:(NSString *)imageUrl_
              placeDescription:(NSString *)placeDescription_
                          city:(MTMappedCity *)city_
{
    self = [super initWithItemId:itemId_
                        itemName:itemName_];
    if (self) {
        
        _itemName = itemName_;
        _latitude = latitude_;
        _longitude = longitude_;
        _imageUrl = imageUrl_;
        _placeDescription = placeDescription_;
        _city = city_;
        
    }
    return self;
}

- (instancetype)initWithItemId:(NSNumber *)itemId_
                      itemName:(NSString *)itemName_
{
    return [self initWithItemId:itemId_
                       itemName:itemName_
                       latitude:nil
                      longitude:nil
                       imageUrl:nil
               placeDescription:nil
                           city:nil];
}

- (id)mutableCopyWithZone:(NSZone *)zone
{
    return [[MTMutablePlace allocWithZone:zone] initWithItemId:self.itemId
                                                      itemName:self.itemName
                                                      latitude:self.latitude
                                                     longitude:self.longitude
                                                      imageUrl:self.imageUrl
                                              placeDescription:self.placeDescription
                                                          city:self.city];
}

@end
