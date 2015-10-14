//
//  MTShowPlaceDetailPresenter.h
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 10.10.15.
//  Copyright © 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTRootTablePresenter.h"
#import "MTItemDetailPresenterInterface.h"
#import "MTPlaceDetailFetcherIOInterface.h"
#import "MTImageManagerDelegate.h"

@class MTItemDetailWireframe;

@protocol MTItemDetailViewInterface;

@interface MTShowPlaceDetailPresenter : MTRootTablePresenter
<
    MTPlaceDetailFetcherOutputInterface,
    MTItemDetailPresenterInterface,
    MTImageManagerDelegate
>

@property (nonatomic, weak) UIViewController<MTItemDetailViewInterface> *userInterface;

- (instancetype)initWithPlaceDetailFetcher:(id<MTPlaceDetailFetcherInputInterface>)placeDetailFetcher
                                 wireframe:(MTItemDetailWireframe *)wireframe NS_DESIGNATED_INITIALIZER;

@end
