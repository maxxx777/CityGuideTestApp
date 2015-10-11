//
//  MTPlaceDetailFetcherIOInterface.h
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 10.10.15.
//  Copyright © 2015 MAXIM TSVETKOV. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MTPlaceDetailFetcherInputInterface <NSObject>

- (NSString *)placeName;
- (NSString *)cityName;
- (NSString *)placeDescription;
- (NSDictionary *)placeCoordinates;
- (NSURL *)photoURL;

@end

@protocol MTPlaceDetailFetcherOutputInterface <NSObject>

@end
