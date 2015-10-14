//
//  MTRootDataManager.h
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 07.10.15.
//  Copyright (c) 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTRootDataManagerInterface.h"
#import "MTItemListCacheDelegate.h"

@protocol MTRootDataManagerDelegate;

@interface MTRootDataManager : NSObject
<
    MTRootDataManagerInterface,
    MTItemListCacheDelegate, MTRootDataManagerDelegate
>

- (instancetype)initWithDelegate:(id<MTRootDataManagerDelegate>)delegate NS_DESIGNATED_INITIALIZER;

@end
