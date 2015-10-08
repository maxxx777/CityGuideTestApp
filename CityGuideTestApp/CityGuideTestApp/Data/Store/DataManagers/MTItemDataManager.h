//
//  MTItemDataManager.h
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 07.10.15.
//  Copyright (c) 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTRootDataManager.h"
#import "MTItemDataManagerInterface.h"
#import "MTMergeObjectsOperationDelegate.h"

@class MTItemWebService;

@interface MTItemDataManager : MTRootDataManager
<
    MTItemDataManagerInterface,
    MTMergeObjectsOperationDelegate
>

@property (nonatomic, strong) MTItemWebService *itemWebService;

@end
