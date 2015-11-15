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
@protocol MTAppRouterInterface;

@interface MTImageBrowserPresenter : MTRootPresenter
<
    MTImageBrowserPresenterInterface
>

@property (nonatomic, weak) UIViewController<MTImageBrowserViewInterface> *userInterface;

- (instancetype) __unavailable init;
- (instancetype)initWithImage:(UIImage * _Nonnull)image
                       router:(id<MTAppRouterInterface> _Nonnull)router NS_DESIGNATED_INITIALIZER;

@end
