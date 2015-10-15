//
//  MTImageCache.h
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 15.10.15.
//  Copyright © 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTImageCacheInterface.h"

@interface MTImageCache : NSObject
<
    MTImageCacheInterface
>

- (instancetype) __unavailable init;

+ (MTImageCache *)sharedCache;

@end
