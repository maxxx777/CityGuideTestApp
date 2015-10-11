//
//  ETAuditoryDetailMapViewHelper.m
//  UniversitySchedule
//
//  Created by MAXIM TSVETKOV on 18.06.15.
//  Copyright (c) 2015 Egar Technology Inc. All rights reserved.
//

#import "MTPlaceDetailMapViewHelper.h"
#import "MTMappedPlace.h"

@interface MTPlaceDetailMapViewHelper ()

@property (nonatomic, strong) MTMappedPlace *place;

@end

@implementation MTPlaceDetailMapViewHelper

- (instancetype)initWithPlace:(MTMappedPlace *)place
{
    self = [super init];
    if (self) {
        
        _place = place;
        
    }
    return self;
}

- (void)dealloc
{
    DLog(@"%@ deallocated: %p", NSStringFromClass([self class]), self);
}

- (void)setMapView:(MKMapView *)mapView
{
    _mapView = mapView;
    _mapView.delegate = self;
}

#pragma mark - MKMapViewDelegate

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
    
    static NSString* PinIdentifier = @"PinIndentifier";
    MKPinAnnotationView *pinView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:PinIdentifier];
    
    if (!pinView) {
        
        pinView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:PinIdentifier];
        pinView.pinColor = MKPinAnnotationColorRed;
        pinView.animatesDrop = YES;
        pinView.enabled = YES;
        pinView.canShowCallout = YES;
        
    }
    
    return pinView;
}

@end
