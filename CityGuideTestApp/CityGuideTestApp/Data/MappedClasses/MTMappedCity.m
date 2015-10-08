//
//  MTMappedCity.m
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 08.10.15.
//  Copyright (c) 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTMappedCity.h"

@interface MTMappedCity ()

@property (nonatomic, strong, readwrite) NSArray *places;

@end

@implementation MTMappedCity

- (instancetype)initWithItemId:(NSNumber *)itemId_
                      itemName:(NSString *)itemName_
                        places:(NSArray *)places_
{
    self = [super initWithItemId:itemId_
                        itemName:itemName_];
    if (self) {
        
        _places = places_;
        
    }
    return self;
}

- (instancetype)initWithItemId:(NSNumber *)itemId_
                      itemName:(NSString *)itemName_
{
    return [self initWithItemId:itemId_
                       itemName:itemName_
                         places:nil];
}

@end
