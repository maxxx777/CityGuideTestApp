//
//  MTRootDataManagerInterface.h
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 07.10.15.
//  Copyright (c) 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTRootDataManagerConstants.h"

@protocol MTItemListCacheInterface;
@protocol MTArrayBasedItemListCacheInterface;

@protocol MTRootDataManagerInterface <NSObject>

@optional

- (void)cancelActions;
- (id)mappedObjectAtIndexPath:(NSIndexPath *)indexPath
                itemListCache:(id<MTItemListCacheInterface>)itemListCache;

@end
