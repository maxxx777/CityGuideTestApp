//
//  MTMappedCity.h
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 08.10.15.
//  Copyright (c) 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTMappedItem.h"

@interface MTMappedCity : MTMappedItem

@property (nonatomic, strong, readonly) NSArray *places;

- (instancetype) __unavailable init;
- (instancetype) __unavailable initWithItemId: (NSNumber *)itemId_
                                     itemName: (NSString *)itemName_;
- (instancetype)initWithItemId: (NSNumber *)itemId_
                      itemName: (NSString *)itemName_
                        places: (NSArray *)places_ NS_DESIGNATED_INITIALIZER;

@end
