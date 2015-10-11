//
//  MTShowPlaceDetailPresenterInterface.h
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 10.10.15.
//  Copyright © 2015 MAXIM TSVETKOV. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MTRootTablePresenterInterface.h"

@protocol MTItemDetailPresenterInterface <NSObject, MTRootTablePresenterInterface>

- (void)configureView;

@optional

- (void)leftBarButtonPressed;
- (void)rightBarButtonPressed;

@end
