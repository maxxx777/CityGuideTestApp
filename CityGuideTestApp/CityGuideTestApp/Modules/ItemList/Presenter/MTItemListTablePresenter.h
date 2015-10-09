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
#import "MTItemListExpanderIOInterface.h"

@class MTItemListWireframe;

@protocol MTItemListTableViewInterface;

@interface MTItemListTablePresenter : MTRootTablePresenter
<
    MTItemListTablePresenterInterface,
    MTItemListRequesterOutputInterface,
    MTItemListExpanderOutputInterface
>

@property (nonatomic, weak) UIViewController<MTItemListTableViewInterface> *userInterface;

- (instancetype)initWithItemListRequester:(id<MTItemListRequesterInputInterface>)itemListRequester
                         itemListExpander:(id<MTItemListExpanderInputInterface>)itemListExpander
                                wireframe:(MTItemListWireframe *)wireframe NS_DESIGNATED_INITIALIZER;

@end
