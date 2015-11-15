//
//  MTDataComponentsAssembly.m
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 14.11.15.
//  Copyright © 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTDataComponentsAssembly.h"
#import "MTItemDataManager.h"
#import "MTItemWebService.h"
#import "MTArrayBasedItemListCache.h"

@implementation MTDataComponentsAssembly

- (id<MTItemDataManagerInterface>)itemDataManager
{
    return [TyphoonDefinition withClass:[MTItemDataManager class]
                          configuration:^(TyphoonDefinition *definition){
                              [definition injectProperty:@selector(itemWebService)
                                                    with:[self itemWebService]];
                          }];
}

- (id<MTArrayBasedItemListCacheInterface>)arrayBasedItemListCache
{
    return [TyphoonDefinition withClass:[MTArrayBasedItemListCache class]];
}

- (id<MTItemWebServiceInterface>)itemWebService
{
    return [TyphoonDefinition withClass:[MTItemWebService class]];
}

@end
