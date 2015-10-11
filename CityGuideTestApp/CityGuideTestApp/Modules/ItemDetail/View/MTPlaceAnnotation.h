//
//  ETAddressAnnotation.h
//  UniversitySchedule
//
//  Created by Grigory Avdyushin on 2/18/13.
//  Copyright (c) 2013 Grigory Avdyushin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MTPlaceAnnotation : NSObject <MKAnnotation> {

}

- (instancetype)initWithCoordinate:(CLLocationCoordinate2D)coordinate NS_DESIGNATED_INITIALIZER;

@property (assign, nonatomic) CLLocationCoordinate2D coordinate;

@end
