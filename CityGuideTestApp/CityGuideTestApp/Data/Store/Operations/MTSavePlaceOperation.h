//
//  MTSavePlaceOperation.h
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 11.10.15.
//  Copyright © 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTRootOperation.h"

@class MTMappedPlace;

@protocol MTMergeObjectsOperationDelegate;

@interface MTSavePlaceOperation : MTRootOperation

- (instancetype)initWithPlace:(MTMappedPlace * _Nonnull)place
       mergeOperationDelegate:(id<MTMergeObjectsOperationDelegate> _Nullable)delegate NS_DESIGNATED_INITIALIZER;
- (instancetype) __unavailable init;

@end
