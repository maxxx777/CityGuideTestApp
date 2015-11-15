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

@protocol MTItemDetailViewInterface;
@protocol MTEditPlaceDetailDelegate;
@protocol MTAppRouterInterface;

@interface MTEditPlaceDetailPresenter : MTRootCollectionPresenter
<
    MTPlaceDetailConfiguratorOutputInterface,
    MTItemOperatorOutputInterface,
    MTItemDetailPresenterInterface
>

@property (nonatomic, weak) UIViewController<MTItemDetailViewInterface> *userInterface;

- (instancetype) __unavailable init;
- (instancetype)initWithPlaceDetailConfigurator:(id<MTPlaceDetailConfiguratorInputInterface> _Nonnull)placeDetailConfigurator
                                   itemOperator:(id<MTItemOperatorInputInterface> _Nonnull)itemOperator
                        editPlaceDetailDelegate:(id<MTEditPlaceDetailDelegate> _Nonnull)editPlaceDetailDelegate
                                         router:(id<MTAppRouterInterface>)router NS_DESIGNATED_INITIALIZER;

@end
