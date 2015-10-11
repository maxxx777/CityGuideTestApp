//
//  MTMappedPlace.h
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 08.10.15.
//  Copyright (c) 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTMappedItem.h"

@class MTMappedCity;

@interface MTMappedPlace : MTMappedItem <NSMutableCopying>
{
    NSString *_itemName;
    NSNumber *_latitude;
    NSNumber *_longitude;
    NSString *_imageUrl;
    NSString *_placeDescription;
    NSString *_filePath;
}

@property (nonatomic, strong, readonly) NSNumber *latitude;
@property (nonatomic, strong, readonly) NSNumber *longitude;
@property (nonatomic, strong, readonly) NSString *imageUrl;
@property (nonatomic, strong, readonly) NSString *placeDescription;
@property (nonatomic, strong, readonly) MTMappedCity *city;
@property (nonatomic, strong, readonly) NSString *filePath;

- (instancetype) __unavailable initWithItemId: (NSNumber *)itemId_
                                     itemName: (NSString *)itemName_;
- (instancetype)initWithItemId: (NSNumber *)itemId_
                      itemName: (NSString *)itemName_
                      latitude: (NSNumber *)latitude_
                     longitude: (NSNumber *)longitude_
                      imageUrl: (NSString *)imageUrl_
                      filePath: (NSString *)filePath_
              placeDescription: (NSString *)placeDescription_
                          city: (MTMappedCity *)city_ NS_DESIGNATED_INITIALIZER;

@end
