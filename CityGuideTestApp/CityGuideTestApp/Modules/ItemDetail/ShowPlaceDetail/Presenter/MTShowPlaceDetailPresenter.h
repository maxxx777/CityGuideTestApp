//
//  MTShowPlaceDetailPresenter.h
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 10.10.15.
//  Copyright © 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTRootCollectionPresenter.h"
#import "MTItemDetailPresenterInterface.h"
#import "MTPlaceDetailFetcherIOInterface.h"
#import "MTImageManagerDelegate.h"

@protocol MTItemDetailViewInterface;
@protocol MTAppRouterInterface;

@interface MTShowPlaceDetailPresenter : MTRootCollectionPresenter
<
    MTPlaceDetailFetcherOutputInterface,
    MTItemDetailPresenterInterface,
    MTImageManagerDelegate
>

@property (nonatomic, weak) UIViewController<MTItemDetailViewInterface> *userInterface;

- (instancetype) __unavailable init;
- (instancetype)initWithPlaceDetailFetcher:(id<MTPlaceDetailFetcherInputInterface>)placeDetailFetcher
                                    router:(id<MTAppRouterInterface>)router NS_DESIGNATED_INITIALIZER;

@end
