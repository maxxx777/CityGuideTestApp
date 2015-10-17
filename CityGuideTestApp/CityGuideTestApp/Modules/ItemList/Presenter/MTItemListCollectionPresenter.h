//
//  MTItemListTablePresenter.h
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 07.10.15.
//  Copyright (c) 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTRootCollectionPresenter.h"
#import "MTItemListCollectionPresenterInterface.h"
#import "MTItemListRequesterIOInterface.h"
#import "MTItemListExpanderIOInterface.h"
#import "MTItemListChangeDetectorIOInterface.h"

@class MTItemListWireframe;

@protocol MTItemListCollectionViewInterface;

@interface MTItemListCollectionPresenter : MTRootCollectionPresenter
<
    MTItemListCollectionPresenterInterface,
    MTItemListRequesterOutputInterface,
    MTItemListExpanderOutputInterface,
    MTItemListChangeDetectorOutputInterface
>

@property (nonatomic, weak) UIViewController<MTItemListCollectionViewInterface> *userInterface;

- (instancetype) __unavailable init;

- (instancetype)initWithItemListRequester:(id<MTItemListRequesterInputInterface>)itemListRequester
                         itemListExpander:(id<MTItemListExpanderInputInterface>)itemListExpander
                   itemListChangeDetector:(id<MTItemListChangeDetectorInputInterface>)itemListChangeDetector
                                wireframe:(MTItemListWireframe *)wireframe NS_DESIGNATED_INITIALIZER;

@end
