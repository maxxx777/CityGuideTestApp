//
//  MTItemListSearchPresenter.h
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 07.10.15.
//  Copyright (c) 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTItemListSearchPresenterInterface.h"
#import "MTRootPresenter.h"
#import "MTItemListRequesterIOInterface.h"
#import "MTItemListSearcherIOInterface.h"

@protocol MTItemListSearchViewInterface;

@class MTItemListWireframe;

@interface MTItemListSearchPresenter : MTRootPresenter
<
    MTItemListSearchPresenterInterface,
    MTItemListRequesterOutputInterface,
    MTItemListSearcherOutputInterface
>

@property (nonatomic, weak) id<MTItemListSearchViewInterface>userInterface;

- (instancetype)initWithItemListRequester:(id<MTItemListRequesterInputInterface>)itemListRequester
                         itemListSearcher:(id<MTItemListSearcherInputInterface>)itemListSearcher
                                wireframe:(MTItemListWireframe *)wireframe NS_DESIGNATED_INITIALIZER;

@end
