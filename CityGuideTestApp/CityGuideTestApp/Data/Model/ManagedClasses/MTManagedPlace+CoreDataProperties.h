//
//  MTManagedPlace+CoreDataProperties.h
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 08.10.15.
//  Copyright © 2015 MAXIM TSVETKOV. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "MTManagedPlace.h"

NS_ASSUME_NONNULL_BEGIN

@interface MTManagedPlace (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *imageUrl;
@property (nullable, nonatomic, retain) NSString *itemDescription;
@property (nullable, nonatomic, retain) NSNumber *latitude;
@property (nullable, nonatomic, retain) NSNumber *longitude;
@property (nullable, nonatomic, retain) MTManagedCity *city;
@property (nullable, nonatomic, retain) NSString *filePath;

@end

NS_ASSUME_NONNULL_END
