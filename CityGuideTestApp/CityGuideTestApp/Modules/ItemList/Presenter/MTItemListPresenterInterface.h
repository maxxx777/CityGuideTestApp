//
//  MTItemListPresenterInterface.h
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 07.10.15.
//  Copyright (c) 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTRootPresenterInterface.h"

@protocol MTItemListPresenterInterface <NSObject, MTRootPresenterInterface>

@optional

- (void)configureView;
- (void)updateViewBeforeAppearing;
- (void)updateViewAfterAppearing;
- (void)leftBarButtonPressed;
- (void)rightBarButtonPressed;

@end
