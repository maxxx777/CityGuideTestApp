//
//  MTMergeItemsOperation.m
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 07.10.15.
//  Copyright (c) 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTSaveItemsOperation.h"
#import "MTMergeObjectsOperationDelegate.h"
#import "NSString+MTSpecificStrings.h"
#import "MTDataStore.h"
#import "NSObject+MTMergeObjects.h"
#import "NSObject+MTMergeObject.h"
#import "MTMappedCity.h"

@interface MTSaveItemsOperation ()

@property (nonatomic, strong) NSArray *items;
@property (nonatomic, weak) id<MTMergeObjectsOperationDelegate> delegate;

@end

@implementation MTSaveItemsOperation

- (instancetype)initWithItems:(NSArray *)items
                     delegate:(id<MTMergeObjectsOperationDelegate>)delegate
{
    self = [super init];
    if (self) {
        
        _items = items;
        _delegate = delegate;
        
    }
    return self;
}

- (void)main
{
    NSError *error = nil;
    NSManagedObjectContext *context = [[MTDataStore sharedStore] privateQueueContext];
    
    BOOL success = NO;
    
    for (MTMappedCity *mappedCity in self.items) {
        success = [self mt_mergeObjectWithEntity:@"MTManagedCity"
                                         mappedObject:mappedCity
                                       additionalData:nil
                                            predicate:[NSPredicate predicateWithFormat:@"itemId == %@", mappedCity.itemId]
                                              context:context
                                                error:&error];
        if (success) {
            NSManagedObject *managedCity = [[MTDataStore sharedStore] objectForEntity:@"MTManagedCity"
                                                                            predicate:[NSPredicate predicateWithFormat:@"itemId == %@", mappedCity.itemId]
                                                                    sortedDescriptors:nil
                                                                              context:context];
            if (managedCity) {
                success = [self mt_mergeObjects:mappedCity.places
                                 idPropertyName:[NSString mt_propertyNameForItemId]
                                         entity:@"MTManagedPlace"
                                 additionalData:managedCity
                                      predicate:nil
                                   mergeChanges:YES
                                        context:context
                                          error:&error];
            }
        }
    }
    
    if (self.isCancelled) {
        [context rollback];
    } else {
        if (success) {
            [[MTDataStore sharedStore] saveContext:context];
        }
    }
    
    [[NSOperationQueue mainQueue] addOperationWithBlock:^
     {
         if ([self.delegate respondsToSelector:@selector(onDidObjectsMergeWithError:isOperationCancelled:)]) {
             [self.delegate onDidObjectsMergeWithError:error
                                  isOperationCancelled:self.isCancelled];
         }
     }];
}

@end
