//
//  MTImageLoader.h
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 11.10.15.
//  Copyright © 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTImageManagerInterface.h"
#import "MTMergeObjectsOperationDelegate.h"

@interface MTImageManager : NSObject
<
    MTImageManagerInterface,
    MTMergeObjectsOperationDelegate
>

- (instancetype) __unavailable init;

+ (MTImageManager *)sharedManager;

@end
