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
- (id)objectAtIndexPath:(NSIndexPath * _Nonnull)indexPath;
- (BOOL)isCityObjectAtIndexPath:(NSIndexPath * _Nonnull)indexPath;
- (BOOL)isOpenedCityAtIndexPath:(NSIndexPath * _Nonnull)indexPath;
- (void)openOrCloseCityAtIndexPath:(NSIndexPath * _Nonnull)indexPath;
- (void)closeAllCities;

@end

@protocol MTItemListExpanderOutputInterface <NSObject>

@optional

- (void)onDidOpenCityPlacesAtIndexPaths:(NSArray * _Nonnull)indexPaths;
- (void)onDidCloseCityPlacesAtIndexPaths:(NSArray * _Nonnull)indexPaths;
- (void)onDidCloseAllCities;

@end
