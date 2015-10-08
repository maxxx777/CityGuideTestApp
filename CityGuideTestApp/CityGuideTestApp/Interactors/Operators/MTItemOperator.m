//
//  MTItemOperator.m
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 08.10.15.
//  Copyright (c) 2015 Egar Technology Inc. All rights reserved.
//

#import "MTItemOperator.h"
#import "MTItemListCacheInterface.h"
#import "MTItemDataManagerInterface.h"

@interface MTItemOperator ()

@property (nonatomic, strong) id<MTItemListCacheInterface>itemListCache;
@property (nonatomic, strong) id<MTItemDataManagerInterface>itemDataManager;

@end

@implementation MTItemOperator

- (instancetype)initWithItemListCache:(id<MTItemListCacheInterface>)itemListCache
                      itemDataManager:(id<MTItemDataManagerInterface>)itemDataManager
{
    self = [super init];
    if (self) {
        
        _itemListCache = itemListCache;
        _itemDataManager = itemDataManager;
        
    }
    return self;
}

#pragma mark - MTNoteOperatorInputInterface

- (void)saveItem:(id)note
{

}

@end
