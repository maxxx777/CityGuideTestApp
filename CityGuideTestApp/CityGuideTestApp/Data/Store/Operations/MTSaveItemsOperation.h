//
//  MTMergeItemsOperation.h
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 07.10.15.
//  Copyright (c) 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTRootOperation.h"

@protocol MTMergeObjectsOperationDelegate;

@interface MTSaveItemsOperation : MTRootOperation

- (instancetype) __unavailable init;
- (instancetype)initWithItems:(NSArray *)items
                     delegate:(id<MTMergeObjectsOperationDelegate>)delegate NS_DESIGNATED_INITIALIZER;

@end
