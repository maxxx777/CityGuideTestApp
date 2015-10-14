//
//  MTPlaceConfiguratorIOInterface.h
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 11.10.15.
//  Copyright © 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTPlaceDetailFetcherIOInterface.h"

@protocol MTPlaceDetailConfiguratorInputInterface <NSObject, MTPlaceDetailFetcherInputInterface>

- (void)configurePlaceCoordinates:(NSDictionary * _Nonnull)coordinates;
- (void)configurePlaceName:(NSString * _Nonnull)name;
- (void)configurePlaceDescription:(NSString * _Nonnull)description;
- (void)configurePlaceFileName:(NSString * _Nonnull)fileName;

@end

@protocol MTPlaceDetailConfiguratorOutputInterface <NSObject, MTPlaceDetailFetcherOutputInterface>

@optional

- (void)onDidConfigurePlaceCoordinates;
- (void)onDidConfigurePlaceName;
- (void)onDidConfigurePlaceDescription;
- (void)onDidConfigurePlaceFileName;

@end
