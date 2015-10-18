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
@protocol MTEditPlaceDetailDelegate;

@interface MTItemListWireframe : MTRootWireframe
<
    MTItemListModuleInterface
>

@property (nonatomic, strong, nonnull) id<MTItemDetailModuleInterface> _Nonnull itemDetailModule;
@property (nonatomic, strong, nonnull) id<MTItemDetailModuleInterface> _Nonnull addItemModule;

- (void)onDidAddNewItemWithDelegate:(id<MTEditPlaceDetailDelegate>)delegate;
- (void)onDidSelectItem:(__nonnull id)item
               fromRect:(CGRect)rect;

@end
