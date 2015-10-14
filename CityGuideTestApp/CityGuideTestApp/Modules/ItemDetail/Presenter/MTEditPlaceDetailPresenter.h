//
//  MTShowPlaceDetailPresenter.h
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 10.10.15.
//  Copyright © 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTRootTablePresenter.h"
#import "MTItemDetailPresenterInterface.h"
#import "MTPlaceDetailConfiguratorIOInterface.h"
#import "MTItemOperatorIOInterface.h"

@class MTItemDetailWireframe;

@protocol MTItemDetailViewInterface;

@interface MTEditPlaceDetailPresenter : MTRootTablePresenter
<
    MTPlaceDetailConfiguratorOutputInterface,
    MTItemOperatorOutputInterface,
    MTItemDetailPresenterInterface
>

@property (nonatomic, weak) UIViewController<MTItemDetailViewInterface> *userInterface;

- (instancetype) __unavailable init;
- (instancetype)initWithPlaceDetailConfigurator:(id<MTPlaceDetailConfiguratorInputInterface>)placeDetailConfigurator
                                   itemOperator:(id<MTItemOperatorInputInterface>)itemOperator
                                      wireframe:(MTItemDetailWireframe *)wireframe NS_DESIGNATED_INITIALIZER;

@end
