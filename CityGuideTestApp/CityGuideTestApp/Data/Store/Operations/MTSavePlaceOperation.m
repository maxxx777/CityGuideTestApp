//
//  MTSaveNoteOperation.m
//  NotesTestApp
//
//  Created by MAXIM TSVETKOV on 30.09.15.
//  Copyright (c) 2015 Grigory Avdyushin. All rights reserved.
//

#import "MTSavePlaceOperation.h"
#import "MTMappedPlace.h"
#import "MTMappedCity.h"
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
    NSManagedObjectContext *context = [MTDataStore sharedStore].privateQueueContext;
    
    NSPredicate *predicate;
    if (self.place.city && self.place.city.itemId) {
        predicate = [NSPredicate predicateWithFormat:@"itemId == %@", self.place.city.itemId];
    } else {
        predicate = [NSPredicate predicateWithFormat:@"itemId == 0"];
    }
    NSManagedObject *managedCity = [[MTDataStore sharedStore] objectForEntity:@"MTManagedCity"
                                                                    predicate:predicate
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
    
    __block BOOL isCancelledOperation = self.isCancelled;
    
    [[NSOperationQueue mainQueue] addOperationWithBlock:^
     {
         if ([self.delegate respondsToSelector:@selector(onDidObjectMergeWithError:object:isOperationCancelled:)]) {
             
             NSManagedObject *managedPlace = [[MTDataStore sharedStore] objectForEntity:@"MTManagedPlace"
                                                                              predicate:[NSPredicate predicateWithFormat:@"itemId == %@", self.place.itemId]
                                                                      sortedDescriptors:nil
                                                                                context:[MTDataStore sharedStore].mainQueueContext];
             MTDataMapping *dataMapping = [[MTDataMapping alloc] init];
             MTMappedPlace *mappedPlace = [dataMapping mappedObjectFromManagedObject:managedPlace];
             
             [self.delegate onDidObjectMergeWithError:error
                                               object:mappedPlace
                                 isOperationCancelled:isCancelledOperation];
         }
     }];
}

@end
