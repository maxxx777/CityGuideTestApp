//
//  MTMappedItem.m
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 08.10.15.
//  Copyright (c) 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTMappedItem.h"

@interface MTMappedItem ()

@end

@implementation MTMappedItem

- (instancetype)initWithItemId:(NSNumber *)itemId_
                      itemName:(NSString *)itemName_
{
    self = [super init];
    if (self) {
        _itemId = itemId_;
        _itemName = itemName_;
    }
    return self;
}

- (instancetype)init
{
    return [self initWithItemId:nil
                       itemName:nil];
}

@end
