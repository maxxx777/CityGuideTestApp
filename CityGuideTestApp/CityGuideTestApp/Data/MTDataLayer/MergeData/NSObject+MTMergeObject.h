//
//  NSObject+MTMergeObject.h
//  VIPERDemoApp
//
//  Created by MAXIM TSVETKOV on 06.09.15.
//  Copyright (c) 2015 MAXIM TSVETKOV. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (MTMergeObject)

- (BOOL)mt_mergeObjectWithEntity: (NSString * _Nonnull)entityName
                    mappedObject: (id _Nullable)mappedObject
                  additionalData: (id _Nullable)additionalData
                       predicate: (NSPredicate * _Nullable)predicate
                    mergeChanges: (BOOL)mergeChanges
                         context: (NSManagedObjectContext * _Nonnull)context
                           error: (NSError * __autoreleasing *)error;
- (BOOL)mt_mergeObjectWithEntity: (NSString * _Nonnull)entityName
                    mappedObject: (id _Nullable)mappedObject
                  additionalData: (id _Nullable)additionalData
                       predicate: (NSPredicate * _Nullable)predicate
                         context: (NSManagedObjectContext * _Nonnull)context
                           error: (NSError * __autoreleasing * _Nullable)error;
- (void)mt_updateObject: (NSManagedObject * _Nullable)object
           mappedObject: (id _Nullable)mappedObject
         additionalData: (id _Nullable)additionalData
                 entity: (NSString * _Nonnull)entityName
           mergeChanges: (BOOL)mergeChanges
                context: (NSManagedObjectContext * _Nonnull)context;
- (void)mt_insertObjectWithMappedObject: (id _Nullable)mappedObject
                         additionalData: (id _Nullable)additionalData
                                 entity: (NSString * _Nonnull)entityName
                                context: (NSManagedObjectContext * _Nonnull)context;

@end
