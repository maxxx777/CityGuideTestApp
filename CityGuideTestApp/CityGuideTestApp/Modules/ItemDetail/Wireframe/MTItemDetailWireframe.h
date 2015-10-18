//
//  MTItemDetailWireframe.h
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 07.10.15.
//  Copyright (c) 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTRootWireframe.h"
#import "MTItemDetailModuleInterface.h"

@protocol MTImageBrowserModuleInterface;
@protocol MTEditPlaceDetailDelegate;

@interface MTItemDetailWireframe : MTRootWireframe
<
    MTItemDetailModuleInterface
>

@property (nonatomic, strong, nonnull) id<MTImageBrowserModuleInterface> _Nonnull imageBrowserModule;

- (void)onDidSelectImage:(UIImage * _Nonnull)image;

@end
