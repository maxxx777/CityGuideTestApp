//
//  MTImageBrowserPresenter.h
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 12.10.15.
//  Copyright © 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTRootPresenter.h"
#import "MTImageBrowserPresenterInterface.h"

@protocol MTImageBrowserViewInterface;

@class MTImageBrowserWireframe;

@interface MTImageBrowserPresenter : MTRootPresenter
<
    MTImageBrowserPresenterInterface
>

@property (nonatomic, weak) UIViewController<MTImageBrowserViewInterface> *userInterface;

- (instancetype) __unavailable init;
- (instancetype)initWithImage:(UIImage *)image
                    wireframe:(MTImageBrowserWireframe *)wireframe NS_DESIGNATED_INITIALIZER;

@end
