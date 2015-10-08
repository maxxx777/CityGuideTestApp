//
//  MTOperationManager.h
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 07.10.15.
//  Copyright (c) 2015 MAXIM TSVETKOV. All rights reserved.
//

@class MTRootOperation;

@interface MTOperationManager : NSObject

@property (nonatomic, strong) NSOperationQueue* sharedOperationQueue;

- (instancetype) __unavailable init;

+ (MTOperationManager *)sharedManager;

- (void)queueOperation:(MTRootOperation *)operation;
- (void)cancelAllOperations;

@end
