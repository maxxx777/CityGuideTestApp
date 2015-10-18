//
//  MTItemOperator.h
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 08.10.15.
//  Copyright (c) 2015 Egar Technology Inc. All rights reserved.
//

#import "MTRootInteractor.h"
#import "MTItemOperatorIOInterface.h"

@protocol MTItemListCacheInterface;
@protocol MTItemDataManagerInterface;

@interface MTItemOperator : MTRootInteractor
<
    MTItemOperatorInputInterface
>

- (instancetype)initWithItemListCache:(id<MTItemListCacheInterface> _Nonnull)itemListCache
                      itemDataManager:(id<MTItemDataManagerInterface> _Nonnull)itemDataManager NS_DESIGNATED_INITIALIZER;
- (instancetype) __unavailable init;

@end
