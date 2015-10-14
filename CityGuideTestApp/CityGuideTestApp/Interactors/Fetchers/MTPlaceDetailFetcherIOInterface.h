//
//  MTPlaceDetailFetcherIOInterface.h
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 10.10.15.
//  Copyright © 2015 MAXIM TSVETKOV. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MTPlaceDetailFetcherInputInterface <NSObject>

@property (NS_NONATOMIC_IOSONLY, readonly, copy) NSString *placeName;
@property (NS_NONATOMIC_IOSONLY, readonly, copy) NSString *cityName;
@property (NS_NONATOMIC_IOSONLY, readonly, copy) NSString *placeDescription;
@property (NS_NONATOMIC_IOSONLY, readonly, copy) NSDictionary *placeCoordinates;
@property (NS_NONATOMIC_IOSONLY, readonly, copy) NSURL *photoURL;
@property (NS_NONATOMIC_IOSONLY, readonly, copy) NSString *fileName;

@property (NS_NONATOMIC_IOSONLY, readonly, strong) id currentItem;

- (void)refreshCurrentItem;

@end

@protocol MTPlaceDetailFetcherOutputInterface <NSObject>

@optional

- (void)onDidRefreshCurrentItem;

@end
