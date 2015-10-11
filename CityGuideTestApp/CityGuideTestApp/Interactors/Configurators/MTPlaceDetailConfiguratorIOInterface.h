//
//  MTPlaceConfiguratorIOInterface.h
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 11.10.15.
//  Copyright © 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTPlaceDetailFetcherIOInterface.h"

@protocol MTPlaceDetailConfiguratorInputInterface <NSObject, MTPlaceDetailFetcherInputInterface>

- (void)configurePlaceCoordinates:(NSDictionary *)coordinates;
- (void)configurePlaceName:(NSString *)name;
- (void)configurePlaceDescription:(NSString *)description;
- (void)configurePlacePhotoPath:(NSString *)photoPath;

- (id)currentItem;

@end

@protocol MTPlaceDetailConfiguratorOutputInterface <NSObject, MTPlaceDetailFetcherOutputInterface>

@optional

- (void)onDidConfigurePlaceCoordinates;
- (void)onDidConfigurePlaceName;
- (void)onDidConfigurePlaceDescription;
- (void)onDidConfigurePlacePhotoPath;

@end
