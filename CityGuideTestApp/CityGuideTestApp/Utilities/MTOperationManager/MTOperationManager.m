//
//  MTOperationManager.m
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 07.10.15.
//  Copyright (c) 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTOperationManager.h"
#import "MTRootOperation.h"

@interface MTOperationManager ()

@property (nonatomic, strong) NSOperationQueue* sharedOperationQueue;

@end

@implementation MTOperationManager

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.sharedOperationQueue = [[NSOperationQueue alloc] init];
        self.sharedOperationQueue.maxConcurrentOperationCount = 1;
    }
    return self;
}

+ (MTOperationManager *)sharedManager
{
    static id sharedInstance;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

#pragma mark - Public

- (void)queueOperationWithBlock:(MTOperationManageCompletionBlock)block
{
    [self.sharedOperationQueue addOperationWithBlock:block];
}

- (void)queueOperation:(MTRootOperation *)operation
{
    [self.sharedOperationQueue addOperation:operation];
}

- (void)cancelAllOperations
{
    [self.sharedOperationQueue cancelAllOperations];
}

@end
