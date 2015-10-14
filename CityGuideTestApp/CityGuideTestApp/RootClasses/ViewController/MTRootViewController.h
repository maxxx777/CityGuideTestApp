//
//  MTRootViewController.h
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 07.10.15.
//  Copyright (c) 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTRootViewInterface.h"

@protocol MTRootPresenterInterface;

@interface MTRootViewController : UIViewController
<
    MTRootViewInterface
>

@property (nonatomic, strong) id<MTRootPresenterInterface> presenter;

@end
