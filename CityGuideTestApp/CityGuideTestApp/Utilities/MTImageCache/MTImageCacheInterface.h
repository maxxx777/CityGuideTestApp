//
//  MTImageCacheInterface.h
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 15.10.15.
//  Copyright © 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTImageCacheCompletionHandlingConstants.h"
#import "MTImageCacheErrorHandlingConstants.h"

@protocol MTImageCacheInterface <NSObject>

- (void)addImageToCacheForPlace:(id _Nonnull)place
                     completion:(MTImageCacheCompletionBlock)completion;
- (UIImage *)imageFromCacheForPlace:(id _Nonnull)place;
- (void)clearImageCache;

@end
