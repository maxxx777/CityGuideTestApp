//
//  MTLocationManager.m
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 09.10.15.
//  Copyright © 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTLocationManager.h"

static NSString *MTSettingsCurrentLocation = @"MTSettingsCurrentLocation";

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
        self.locationManager.distanceFilter = kCLDistanceFilterNone;
        self.locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
        
    }
    return self;
}

+ (MTLocationManager *)sharedManager
{
    static MTLocationManager *sharedManager = nil;
    static dispatch_once_t isDispatched;
    
    dispatch_once(&isDispatched, ^
                  {
                      sharedManager = [[MTLocationManager alloc] init];
                  });
    
    return sharedManager;
}

- (void)detectCurrentLocation
{
    if ([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
        [self.locationManager requestAlwaysAuthorization];
    }
    [self.locationManager startUpdatingLocation];
}

- (BOOL)isCurrentLocationDetected
{
    NSDictionary *currentLocation = [self currentLocation];
    return currentLocation != nil;
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
        CLLocationDistance distance = [radius doubleValue];
        
        CLCircularRegion *circularRegion = [[CLCircularRegion alloc] initWithCenter:centerLocationCoordinate
                                                                            radius:distance
                                                                        identifier:@"MTCircularRegion"];
        
        CLLocationDegrees latitudeToCheck = [latitude doubleValue];
        CLLocationDegrees longitudeToCheck = [longitude doubleValue];
        CLLocationCoordinate2D locationCoordinateToCheck = CLLocationCoordinate2DMake(latitudeToCheck, longitudeToCheck);

        result = [circularRegion containsCoordinate:locationCoordinateToCheck];
    }
    return result;
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    //    DLog(@"detect location succeed");
    
    CLLocation *location = [locations lastObject];
    
    NSDictionary *currentLocation = @{
                                      @"latitude" : [NSNumber numberWithDouble:location.coordinate.latitude],
                                      @"longitude" : [NSNumber numberWithDouble:location.coordinate.longitude]
                                      };
    [[NSUserDefaults standardUserDefaults] setObject:currentLocation
                                              forKey:MTSettingsCurrentLocation];
    
    [self.locationManager stopUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    [self.locationManager stopUpdatingLocation];
}

#pragma mark - Helper

- (NSDictionary *)currentLocation
{
    return [[NSUserDefaults standardUserDefaults] valueForKey:MTSettingsCurrentLocation];
}

@end
