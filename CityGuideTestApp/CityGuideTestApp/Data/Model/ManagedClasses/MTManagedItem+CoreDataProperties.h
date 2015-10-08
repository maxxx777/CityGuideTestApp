//
//  MTManagedItem+CoreDataProperties.h
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 08.10.15.
//  Copyright © 2015 MAXIM TSVETKOV. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "MTManagedItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface MTManagedItem (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *itemId;
@property (nullable, nonatomic, retain) NSString *itemName;

@end

NS_ASSUME_NONNULL_END
