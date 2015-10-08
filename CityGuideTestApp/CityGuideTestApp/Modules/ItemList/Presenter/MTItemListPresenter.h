//
//  MTItemListPresenter.h
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 07.10.15.
//  Copyright (c) 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTRootPresenter.h"
#import "MTItemListPresenterInterface.h"

@protocol MTItemListViewInterface;

@class MTItemListWireframe;

@interface MTItemListPresenter : MTRootPresenter
<
    MTItemListPresenterInterface
>

@property (nonatomic, weak) UIViewController<MTItemListViewInterface> *userInterface;

- (instancetype)initWithWireframe:(MTItemListWireframe *)wireframe NS_DESIGNATED_INITIALIZER;

@end
