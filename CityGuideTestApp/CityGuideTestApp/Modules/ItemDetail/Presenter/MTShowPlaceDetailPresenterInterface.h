//
//  MTShowPlaceDetailPresenterInterface.h
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 10.10.15.
//  Copyright © 2015 MAXIM TSVETKOV. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MTRootTablePresenterInterface.h"

@protocol MTShowPlaceDetailPresenterInterface <NSObject, MTRootTablePresenterInterface>

- (void)configureView;

@end
