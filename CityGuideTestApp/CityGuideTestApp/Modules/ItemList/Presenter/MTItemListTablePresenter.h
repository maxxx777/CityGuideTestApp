//
//  MTItemListTablePresenter.h
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 07.10.15.
//  Copyright (c) 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTRootTablePresenter.h"
#import "MTItemListTablePresenterInterface.h"
#import "MTItemListRequesterIOInterface.h"
#import "MTItemListFetcherIOInterface.h"

@class MTItemListWireframe;

@protocol MTItemListTableViewInterface;

@interface MTItemListTablePresenter : MTRootTablePresenter
<
    MTItemListTablePresenterInterface,
    MTItemListRequesterOutputInterface,
    MTItemListFetcherOutputInterface
>

@property (nonatomic, weak) UIViewController<MTItemListTableViewInterface> *userInterface;

- (instancetype)initWithItemListRequester:(id<MTItemListRequesterInputInterface>)itemListRequester
                          cityListFetcher:(id<MTItemListFetcherInputInterface>)cityListFetcher
                         placeListFetcher:(id<MTItemListFetcherInputInterface>)placeListFetcher
                                wireframe:(MTItemListWireframe *)wireframe NS_DESIGNATED_INITIALIZER;

@end
