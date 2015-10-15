//
//  MTOperationManager.h
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 07.10.15.
//  Copyright (c) 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTOperationManagerInterface.h"

@interface MTOperationManager : NSObject
<
    MTOperationManagerInterface
>

- (instancetype) __unavailable init;

+ (MTOperationManager *)sharedManager;

@end
