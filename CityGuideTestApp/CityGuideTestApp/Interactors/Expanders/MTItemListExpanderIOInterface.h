//
//  MTItemListExpanderIOInterface.h
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 08.10.15.
//  Copyright © 2015 MAXIM TSVETKOV. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MTItemListExpanderInputInterface <NSObject>

@property (NS_NONATOMIC_IOSONLY, readonly) NSUInteger numberOfRows;
- (id)objectAtIndexPath:(NSIndexPath *)indexPath;
- (BOOL)isCityObjectAtIndexPath:(NSIndexPath *)indexPath;
- (BOOL)isOpenedCityAtIndexPath:(NSIndexPath *)indexPath;
- (void)openOrCloseCityAtIndexPath:(NSIndexPath *)indexPath;
- (void)closeAllCities;

@end

@protocol MTItemListExpanderOutputInterface <NSObject>

@optional

- (void)onDidOpenCityPlacesAtIndexPaths:(NSArray *)indexPaths;
- (void)onDidCloseCityPlacesAtIndexPaths:(NSArray *)indexPaths;
- (void)onDidCloseAllCities;

@end
