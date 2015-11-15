//
//  MTDataComponentsAssembly.h
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 14.11.15.
//  Copyright © 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "TyphoonAssembly.h"

@protocol MTItemDataManagerInterface;
@protocol MTArrayBasedItemListCacheInterface;
@protocol MTItemWebServiceInterface;

@interface MTDataComponentsAssembly : TyphoonAssembly

- (id<MTItemDataManagerInterface>)itemDataManager;
- (id<MTArrayBasedItemListCacheInterface>)arrayBasedItemListCache;
- (id<MTItemWebServiceInterface>)itemWebService;

@end
