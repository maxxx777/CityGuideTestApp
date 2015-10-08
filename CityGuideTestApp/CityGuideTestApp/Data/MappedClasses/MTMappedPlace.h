//
//  MTMappedPlace.h
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 08.10.15.
//  Copyright (c) 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTMappedItem.h"

@class MTMappedCity;

@interface MTMappedPlace : MTMappedItem

@property (nonatomic, strong, readonly) NSNumber *latitude;
@property (nonatomic, strong, readonly) NSNumber *longitude;
@property (nonatomic, strong, readonly) NSString *imageUrl;
@property (nonatomic, strong, readonly) NSString *placeDescription;
@property (nonatomic, strong, readonly) MTMappedCity *city;

- (instancetype) __unavailable init;
- (instancetype) __unavailable initWithItemId: (NSNumber *)itemId_
                                     itemName: (NSString *)itemName_;
- (instancetype)initWithItemId: (NSNumber *)itemId_
                      itemName: (NSString *)itemName_
                      latitude: (NSNumber *)latitude_
                     longitude: (NSNumber *)longitude_
                      imageUrl: (NSString *)imageUrl_
              placeDescription: (NSString *)placeDescription_
                          city: (MTMappedCity *)city_ NS_DESIGNATED_INITIALIZER;

@end
