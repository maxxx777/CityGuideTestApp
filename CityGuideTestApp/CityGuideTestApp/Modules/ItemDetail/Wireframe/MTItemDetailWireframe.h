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

@interface MTItemDetailWireframe : MTRootWireframe
<
    MTItemDetailModuleInterface
>

@property (nonatomic, strong, nonnull) id<MTImageBrowserModuleInterface>imageBrowserModule;

- (void)onDidSelectImageWithFileName:(NSString *)fileName;

@end
