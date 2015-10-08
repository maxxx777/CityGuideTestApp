//
//  MTMappedPlace.m
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 08.10.15.
//  Copyright (c) 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTMappedPlace.h"
#import "MTMappedCity.h"

@interface MTMappedPlace ()

@property (nonatomic, strong, readwrite) NSNumber *latitude;
@property (nonatomic, strong, readwrite) NSNumber *longitude;
@property (nonatomic, strong, readwrite) NSString *imageUrl;
@property (nonatomic, strong, readwrite) NSString *placeDescription;
@property (nonatomic, strong, readwrite) MTMappedCity *city;

@end

@implementation MTMappedPlace

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

@end
