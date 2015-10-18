//
//  MTRootDataManagerInterface.h
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 07.10.15.
//  Copyright (c) 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTRootDataManagerCompletionHandlingConstants.h"

@protocol MTItemListCacheInterface;

@protocol MTRootDataManagerInterface <NSObject>

@optional

- (id)mappedObjectAtIndexPath:(NSIndexPath * _Nonnull)indexPath
                itemListCache:(id<MTItemListCacheInterface> _Nonnull)itemListCache;

@end
