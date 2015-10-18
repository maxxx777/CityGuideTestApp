//
//  NSObject+MTMergeObjects.h
//  VIPERDemoApp
//
//  Created by MAXIM TSVETKOV on 06.09.15.
//  Copyright (c) 2015 MAXIM TSVETKOV. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (MTMergeObjects)

- (BOOL)mt_mergeObjects: (NSArray * _Nonnull)objects
         idPropertyName: (NSString * _Nonnull)idPropertyName
                 entity: (NSString * _Nonnull)entityName
         additionalData: (id _Nullable)additionalData
              predicate: (NSPredicate * _Nonnull)predicate
                context: (NSManagedObjectContext * _Nonnull)context
                  error: (NSError * __autoreleasing * _Nullable)error;
- (BOOL)mt_mergeObjects: (NSArray * _Nonnull)objects
         idPropertyName: (NSString * _Nonnull)idPropertyName
                 entity: (NSString * _Nonnull)entityName
         additionalData: (id _Nullable)additionalData
              predicate: (NSPredicate * _Nonnull)predicate
           mergeChanges: (BOOL)mergeChanges
                context: (NSManagedObjectContext * _Nonnull)context
                  error: (NSError * __autoreleasing * _Nullable)error;
- (NSSet *)mt_idsOfObjectsForDeleteWithOldObjectsIds: (NSSet * _Nonnull)oldObjectsIds
                                       newObjectsIds: (NSSet * _Nonnull)newObjectsIds;
- (NSSet *)mt_idsOfObjectsForUpdateWithOldObjectsIds: (NSSet * _Nonnull)oldObjectsIds
                                       newObjectsIds: (NSSet * _Nonnull)newObjectsIds;
- (NSSet *)mt_idsOfObjectsForInsertWithOldObjectsIds: (NSSet * _Nonnull)oldObjectsIds
                                       newObjectsIds: (NSSet * _Nonnull)newObjectsIds;
- (void)mt_deleteObjectsWithIds: (NSSet * _Nonnull)idsOfObjectsForDelete
                 idPropertyName: (NSString * _Nonnull)idPropertyName
                     entityName: (NSString * _Nonnull)entityName
                        context: (NSManagedObjectContext * _Nonnull)context;
- (void)mt_updateObjectsWithIds: (NSSet * _Nonnull)idsOfObjectsForUpdate
                     newObjects: (NSArray * _Nonnull)newObjects
                 additionalData: (id _Nullable)additionalData
                 idPropertyName: (NSString * _Nonnull)idPropertyName
                     entityName: (NSString * _Nonnull)entityName
                        context: (NSManagedObjectContext * _Nonnull)context;
- (void)mt_insertObjectsWithIds: (NSSet * _Nonnull)idsOfObjectsForInsert
                     newObjects: (NSArray * _Nonnull)newObjects
                 additionalData: (id _Nullable)additionalData
                 idPropertyName: (NSString * _Nonnull)idPropertyName
                     entityName: (NSString * _Nonnull)entityName
                        context: (NSManagedObjectContext * _Nonnull)context;

@end
