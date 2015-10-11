//
//  MTItemListWireframe.h
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 07.10.15.
//  Copyright (c) 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTRootWireframe.h"
#import "MTItemListModuleInterface.h"

@protocol MTItemDetailModuleInterface;

@interface MTItemListWireframe : MTRootWireframe
<
    MTItemListModuleInterface
>

@property (nonatomic, strong, nonnull) id<MTItemDetailModuleInterface>itemDetailModule;
@property (nonatomic, strong, nonnull) id<MTItemDetailModuleInterface>addItemModule;

- (void)onDidAddNewItem;
- (void)onDidSelectItem:(__nonnull id)item;

@end
