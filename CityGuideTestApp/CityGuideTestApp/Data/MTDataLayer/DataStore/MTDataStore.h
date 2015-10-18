//
//  MTDataStore.h
//
//  Created by MAXIM TSVETKOV on 03.12.14.
//

#import "MTDataStoreConstants.h"

@interface MTDataStore : NSObject

@property (nonatomic, strong, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, strong, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (strong, nonatomic, readonly) NSManagedObjectContext *mainQueueContext;
@property (strong, nonatomic, readonly) NSManagedObjectContext *privateQueueContext;

- (instancetype) __unavailable init;

+ (MTDataStore *)sharedStore;

- (void)saveContext: (NSManagedObjectContext*)context;

- (NSFetchRequest *)fetchRequestWithEntity: (NSString * _Nonnull)entityName
                                 predicate: (NSPredicate * _Nullable)predicate
                         sortedDescriptors: (NSArray * _Nullable)sortedDescriptors
                                   context: (NSManagedObjectContext * _Nonnull)context;
- (NSFetchRequest *)fetchRequestWithEntity: (NSString * _Nonnull)entityName
                                 predicate: (NSPredicate * _Nullable)predicate
                         sortedDescriptors: (NSArray * _Nullable)sortedDescriptors
                         propertiesToFetch: (NSArray * _Nullable)propertiesToFetch
                       includesSubentities: (BOOL)includesSubentities
                    returnsObjectsAsFaults: (BOOL)returnsObjectsAsFaults
                    includesPendingChanges: (BOOL)includesPendingChanges
                                   context: (NSManagedObjectContext * _Nonnull)context;
- (NSArray *)objectsForEntity: (NSString * _Nonnull)entityName
                    predicate: (NSPredicate * _Nullable)predicate
            sortedDescriptors: (NSArray * _Nullable)sortedDescriptors
                      context: (NSManagedObjectContext * _Nonnull)context;
- (NSArray *)objectsForEntity: (NSString * _Nonnull)entityName
                    predicate: (NSPredicate * _Nullable)predicate
            sortedDescriptors: (NSArray * _Nullable)sortedDescriptors
            propertiesToFetch: (NSArray * _Nullable)propertiesToFetch
          includesSubentities: (BOOL)includesSubentities
       returnsObjectsAsFaults: (BOOL)returnsObjectsAsFaults
       includesPendingChanges: (BOOL)includesPendingChanges
                      context: (NSManagedObjectContext * _Nonnull)context;
- (id)objectForEntity: (NSString * _Nonnull)entityName
            predicate: (NSPredicate * _Nullable)predicate
    sortedDescriptors: (NSArray * _Nullable)sortedDescriptors
              context: (NSManagedObjectContext * _Nonnull)context;
- (id)objectForEntity: (NSString * _Nonnull)entityName
            predicate: (NSPredicate * _Nullable)predicate
    sortedDescriptors: (NSArray * _Nullable)sortedDescriptors
    propertiesToFetch: (NSArray * _Nullable)propertiesToFetch
  includesSubentities: (BOOL)includesSubentities
returnsObjectsAsFaults: (BOOL)returnsObjectsAsFaults
includesPendingChanges: (BOOL)includesPendingChanges
              context: (NSManagedObjectContext * _Nonnull)context;
- (NSUInteger)countOfObjectsForEntity: (NSString * _Nonnull)entityName
                            predicate: (NSPredicate * _Nullable)predicate
                    sortedDescriptors: (NSArray * _Nullable)sortedDescriptors
                              context: (NSManagedObjectContext * _Nonnull)context;
- (NSUInteger)countOfObjectsForEntity: (NSString * _Nonnull)entityName
                            predicate: (NSPredicate * _Nullable)predicate
                    sortedDescriptors: (NSArray * _Nullable)sortedDescriptors
                    propertiesToFetch: (NSArray * _Nullable)propertiesToFetch
                  includesSubentities: (BOOL)includesSubentities
               returnsObjectsAsFaults: (BOOL)returnsObjectsAsFaults
               includesPendingChanges: (BOOL)includesPendingChanges
                              context: (NSManagedObjectContext * _Nonnull)context;
- (void)deleteObject: (NSManagedObject * _Nonnull)object
             context: (NSManagedObjectContext * _Nonnull)context;

@end
