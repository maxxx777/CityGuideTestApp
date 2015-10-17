//
//  MTShowPlaceDetailPresenter.h
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 10.10.15.
//  Copyright © 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTRootCollectionPresenter.h"
#import "MTItemDetailPresenterInterface.h"
#import "MTPlaceDetailConfiguratorIOInterface.h"
#import "MTItemOperatorIOInterface.h"

@class MTItemDetailWireframe;

@protocol MTItemDetailViewInterface;
@protocol MTEditPlaceDetailDelegate;

@interface MTEditPlaceDetailPresenter : MTRootCollectionPresenter
<
    MTPlaceDetailConfiguratorOutputInterface,
    MTItemOperatorOutputInterface,
    MTItemDetailPresenterInterface
>

@property (nonatomic, weak) UIViewController<MTItemDetailViewInterface> *userInterface;

- (instancetype) __unavailable init;
- (instancetype)initWithPlaceDetailConfigurator:(id<MTPlaceDetailConfiguratorInputInterface>)placeDetailConfigurator
                                   itemOperator:(id<MTItemOperatorInputInterface>)itemOperator
                        editPlaceDetailDelegate:(id<MTEditPlaceDetailDelegate>)editPlaceDetailDelegate
                                      wireframe:(MTItemDetailWireframe *)wireframe NS_DESIGNATED_INITIALIZER;

@end
