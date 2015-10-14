//
//  MTMutablePlace.h
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 11.10.15.
//  Copyright © 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTMappedPlace.h"

@interface MTMutablePlace : MTMappedPlace

@property (nonatomic, strong) NSString *itemName;
@property (nonatomic, strong) NSNumber *latitude;
@property (nonatomic, strong) NSNumber *longitude;
@property (nonatomic, strong) NSString *imageUrl;
@property (nonatomic, strong) NSString *fileName;
@property (nonatomic, strong) NSString *placeDescription;

- (instancetype)initWithPlace:(MTMappedPlace *)place_ NS_DESIGNATED_INITIALIZER;

@end
