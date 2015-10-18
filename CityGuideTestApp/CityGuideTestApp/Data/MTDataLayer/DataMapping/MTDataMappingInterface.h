//
//  MTDataMappingInterface.h
//
//  Created by MAXIM TSVETKOV on 06.09.15.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@protocol MTDataMappingInterface <NSObject>

- (id)mappedObjectFromManagedObject: (NSManagedObject * _Nullable)managedObject;
- (NSDictionary*)managedObjectDictFromMappedObject: (id _Nonnull)mappedObject
                                    additionalData: (id _Nullable)additionalData
                                        entityName: (NSString * _Nonnull)entityName;

@end
