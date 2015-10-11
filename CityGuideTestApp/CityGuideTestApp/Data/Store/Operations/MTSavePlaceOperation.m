//
//  MTSaveNoteOperation.m
//  NotesTestApp
//
//  Created by MAXIM TSVETKOV on 30.09.15.
//  Copyright (c) 2015 Grigory Avdyushin. All rights reserved.
//

#import "MTSavePlaceOperation.h"
#import "MTMappedPlace.h"
#import "MTDataStore.h"
#import "MTDataMapping.h"
#import "NSObject+MTMergeObject.h"
#import "MTMergeObjectsOperationDelegate.h"

@interface MTSavePlaceOperation ()

@property (nonatomic, strong) MTMappedPlace *place;
@property (nonatomic, weak) id<MTMergeObjectsOperationDelegate> delegate;

@end

@implementation MTSavePlaceOperation

- (instancetype)initWithPlace:(MTMappedPlace *)place
       mergeOperationDelegate:(id<MTMergeObjectsOperationDelegate>)delegate
{
    if (self = [super init]) {
        
        _place = place;
        _delegate = delegate;
        
    }
    return self;
}

- (void)main
{
    NSError *error = nil;
    NSManagedObjectContext *context = [[MTDataStore sharedStore] privateQueueContext];
    
    NSManagedObject *managedCity = [[MTDataStore sharedStore] objectForEntity:@"MTManagedCity"
                                                                    predicate:[NSPredicate predicateWithFormat:@"itemId == 0"]
                                                            sortedDescriptors:nil
                                                                      context:context];
    
    BOOL success = [self mt_mergeObjectWithEntity:@"MTManagedPlace"
                                     mappedObject:self.place
                                   additionalData:managedCity
                                        predicate:[NSPredicate predicateWithFormat:@"itemId == %@", self.place.itemId]
                                          context:context
                                            error:&error];
    
    if (self.isCancelled) {
        [context rollback];
    } else {
        if (success) {
            [[MTDataStore sharedStore] saveContext:context];
        }
    }
    
    if ([self.delegate respondsToSelector:@selector(onDidObjectMergeWithError:isOperationCancelled:)]) {
        [self.delegate onDidObjectMergeWithError:error
                            isOperationCancelled:self.isCancelled];
    }
}

@end
