//
//  MTSaveNoteOperation.h
//  NotesTestApp
//
//  Created by MAXIM TSVETKOV on 30.09.15.
//  Copyright (c) 2015 Grigory Avdyushin. All rights reserved.
//

#import "MTRootOperation.h"

@class MTMappedPlace;

@protocol MTMergeObjectsOperationDelegate;

@interface MTSavePlaceOperation : MTRootOperation

- (instancetype)initWithPlace:(MTMappedPlace *)place
       mergeOperationDelegate:(id<MTMergeObjectsOperationDelegate>)delegate NS_DESIGNATED_INITIALIZER;
- (instancetype) __unavailable init;

@end
