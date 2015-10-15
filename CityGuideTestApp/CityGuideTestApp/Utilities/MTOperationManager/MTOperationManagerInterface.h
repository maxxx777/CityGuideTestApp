//
//  MTOperationManagerInterface.h
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 15.10.15.
//  Copyright © 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTOperationManagerCompletionHandlingConstants.h"

@class MTRootOperation;

@protocol MTOperationManagerInterface <NSObject>

- (void)queueOperationWithBlock:(MTOperationManageCompletionBlock)block;
- (void)queueOperation:(MTRootOperation *)operation;
- (void)cancelAllOperations;

@end
