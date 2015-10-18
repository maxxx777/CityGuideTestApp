//
//  MTItemListPresenter.h
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 07.10.15.
//  Copyright (c) 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTRootPresenter.h"
#import "MTItemListRequesterIOInterface.h"
#import "MTItemListPresenterInterface.h"
#import "MTEditPlaceDetailDelegate.h"

@protocol MTItemListViewInterface;

@class MTItemListWireframe;

@interface MTItemListPresenter : MTRootPresenter
<
    MTItemListPresenterInterface,
    MTItemListRequesterOutputInterface,
    MTEditPlaceDetailDelegate
>

@property (nonatomic, weak) UIViewController<MTItemListViewInterface> * userInterface;

- (instancetype) __unavailable init;
- (instancetype)initWithItemListRequester:(id<MTItemListRequesterInputInterface> _Nonnull)itemListRequester
                                wireframe:(MTItemListWireframe * _Nonnull)wireframe NS_DESIGNATED_INITIALIZER;

@end
