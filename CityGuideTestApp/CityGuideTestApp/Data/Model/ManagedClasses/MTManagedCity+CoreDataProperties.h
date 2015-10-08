//
//  MTManagedCity+CoreDataProperties.h
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 08.10.15.
//  Copyright © 2015 MAXIM TSVETKOV. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "MTManagedCity.h"

NS_ASSUME_NONNULL_BEGIN

@interface MTManagedCity (CoreDataProperties)

@property (nullable, nonatomic, retain) NSSet<NSManagedObject *> *places;

@end

@interface MTManagedCity (CoreDataGeneratedAccessors)

- (void)addPlacesObject:(NSManagedObject *)value;
- (void)removePlacesObject:(NSManagedObject *)value;
- (void)addPlaces:(NSSet<NSManagedObject *> *)values;
- (void)removePlaces:(NSSet<NSManagedObject *> *)values;

@end

NS_ASSUME_NONNULL_END
