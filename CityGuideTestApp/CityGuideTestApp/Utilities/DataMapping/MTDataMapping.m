//
//  MTDataMapping.m
//
//  Created by MAXIM TSVETKOV on 28.08.15.
//

#import "MTDataMapping.h"
#import "MTMappedCity.h"
#import "MTMappedPlace.h"
#import "MTManagedCity.h"
#import "MTManagedPlace.h"

@implementation MTDataMapping

- (id)mappedObjectFromManagedObject: (NSManagedObject *)managedObject
{
    if (managedObject == nil) {
        return nil;
    }
    
    if ([managedObject isKindOfClass:[MTManagedCity class]]) {
        
        return [[MTMappedCity alloc] initWithItemId:[managedObject valueForKey:@"itemId"]
                                           itemName:[managedObject valueForKey:@"itemName"]
                                             places:nil];
        
    } else if ([managedObject isKindOfClass:[MTManagedPlace class]]) {
        
        NSManagedObject *managedCity = [managedObject valueForKey:@"city"];
        
        id mappedCity = [self mappedObjectFromManagedObject:managedCity];
        
        return [[MTMappedPlace alloc] initWithItemId:[managedObject valueForKey:@"itemId"]
                                            itemName:[managedObject valueForKey:@"itemName"]
                                            latitude:[managedObject valueForKey:@"latitude"]
                                           longitude:[managedObject valueForKey:@"longitude"]
                                            imageUrl:[managedObject valueForKey:@"imageUrl"]
                                            fileName:[managedObject valueForKey:@"fileName"]
                                    placeDescription:[managedObject valueForKey:@"itemDescription"]
                                                city:mappedCity];
    }
    
    return nil;
}

- (NSDictionary *)managedObjectDictFromMappedObject:(id)mappedObject
                                     additionalData:(id)additionalData
                                         entityName:(NSString *)entityName
{
    if ([entityName isEqualToString:@"MTManagedCity"]) {
        
        NSMutableDictionary* result = [[NSMutableDictionary alloc] init];
        MTMappedCity *mappedCity = (MTMappedCity *)mappedObject;
        
        if (mappedCity.itemId) {
            result[@"itemId"] = mappedCity.itemId;
        }
        
        if (mappedCity.itemName) {
            result[@"itemName"] = mappedCity.itemName;
        }
        
        return result;
        
    } else if ([entityName isEqualToString:@"MTManagedPlace"]) {
        
        NSMutableDictionary* result = [[NSMutableDictionary alloc] init];
        MTMappedPlace *mappedPlace = (MTMappedPlace *)mappedObject;
        
        if (mappedPlace.itemId) {
            result[@"itemId"] = mappedPlace.itemId;
        }
        
        if (mappedPlace.itemName) {
            result[@"itemName"] = mappedPlace.itemName;
        }
        
        if (mappedPlace.latitude) {
            result[@"latitude"] = mappedPlace.latitude;
        }
        
        if (mappedPlace.longitude) {
            result[@"longitude"] = mappedPlace.longitude;
        }
        
        if (mappedPlace.imageUrl) {
            result[@"imageUrl"] = mappedPlace.imageUrl;
        }
        
        if (mappedPlace.fileName) {
            result[@"fileName"] = mappedPlace.fileName;
        }
        
        if (mappedPlace.placeDescription) {
            result[@"itemDescription"] = mappedPlace.placeDescription;
        }
        
        NSManagedObject *city = (NSManagedObject *)additionalData;
        
        if (city != nil) {
            result[@"city"] = city;
        }
        
        return result;
    }
    
    return nil;
}

@end
