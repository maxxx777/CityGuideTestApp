//
//  MTRootDataManager.m
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 07.10.15.
//  Copyright (c) 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTRootDataManager.h"
#import "MTRootDataManagerDelegate.h"
#import "MTItemListCacheInterface.h"
#import "MTDataMapping.h"

@interface MTRootDataManager ()

@property (nonatomic, weak) id<MTRootDataManagerDelegate>delegate;

@end

@implementation MTRootDataManager

- (void)dealloc
{
    DLog(@"%@ deallocated: %p", NSStringFromClass([self class]), self);
}

- (instancetype)initWithDelegate:(id<MTRootDataManagerDelegate>)delegate
{
    self = [super init];
    if (self) {
        
        _delegate = delegate;
        
    }
    return self;
}

- (instancetype)init
{
    return [self initWithDelegate:nil];
}

#pragma mark - MTRootDataManagerInterface

- (id)mappedObjectAtIndexPath:(NSIndexPath *)indexPath
                itemListCache:(id<MTItemListCacheInterface>)itemListCache
{
    MTDataMapping *dataMapping = [[MTDataMapping alloc] init];
    id managedObject = [itemListCache objectAtIndexPath:indexPath];
    return [dataMapping mappedObjectFromManagedObject:managedObject];
}

#pragma mark - MTItemListCacheDelegate

- (void)onDidChangeContent
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(onDidChangeContent)]) {
        [self.delegate onDidChangeContent];
    }
}

@end
