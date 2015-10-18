//
//  MTLocationManager.m
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 09.10.15.
//  Copyright © 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTLocationManager.h"

@interface MTLocationManager ()

@property (nonatomic, strong) CLLocationManager *locationManager;

@end

@implementation MTLocationManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
        self.locationManager.distanceFilter = 500;
        self.locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;

    }
    return self;
}

+ (MTLocationManager *)sharedManager
{
    static id sharedInstance;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

#pragma mark - MTLocationManagerInterface

- (void)detectLocation
{
    //detect location only if it didn't before
    if (![self currentLocation]) {     
        if ([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
            [self.locationManager requestAlwaysAuthorization];
        }
        [self.locationManager startUpdatingLocation]; //TODO: add requestLocation available since iOS 9
    }
}

- (BOOL)isLocationEnabled
{
    return [CLLocationManager locationServicesEnabled] &&
    [CLLocationManager authorizationStatus] != kCLAuthorizationStatusDenied;
}

- (NSDictionary *)currentLocation
{
    NSDictionary *result;
    
    if (self.locationManager.location) {
        result = @{
                 @"latitude" : @(self.locationManager.location.coordinate.latitude),
                 @"longitude" : @(self.locationManager.location.coordinate.longitude)
                 };
    }
    
    return result;
}

- (BOOL)isLocationWithLatitude:(NSNumber *)latitude
                     longitude:(NSNumber *)longitude
                  withinRadius:(NSNumber *)radius
{
    BOOL result = NO;
    NSDictionary *currentLocation = [self currentLocation];
    if (currentLocation) {
        CLLocationDegrees currentLatitude = [[currentLocation valueForKey:@"latitude"] doubleValue];
        CLLocationDegrees currentLongitude = [[currentLocation valueForKey:@"longitude"] doubleValue];
        CLLocationCoordinate2D centerLocationCoordinate = CLLocationCoordinate2DMake(currentLatitude, currentLongitude);
        CLLocationDistance distance = radius.doubleValue;
        
        CLCircularRegion *circularRegion = [[CLCircularRegion alloc] initWithCenter:centerLocationCoordinate
                                                                            radius:distance
                                                                        identifier:@"MTCircularRegion"];
        
        CLLocationDegrees latitudeToCheck = latitude.doubleValue;
        CLLocationDegrees longitudeToCheck = longitude.doubleValue;
        CLLocationCoordinate2D locationCoordinateToCheck = CLLocationCoordinate2DMake(latitudeToCheck, longitudeToCheck);

        result = [circularRegion containsCoordinate:locationCoordinateToCheck];
    }
    return result;
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    //don't stop updating location in order to detect more precise location each time
//    [self.locationManager stopUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    //don't stop updating location in order to detect more precise location each time
//    [self.locationManager stopUpdatingLocation];
}

@end
