//
//  ETAuditoryDetailMapViewHelper.h
//  UniversitySchedule
//
//  Created by MAXIM TSVETKOV on 18.06.15.
//  Copyright (c) 2015 Egar Technology Inc. All rights reserved.
//

#import <MapKit/MapKit.h>

@class MTMappedPlace;

@interface MTPlaceDetailMapViewHelper : NSObject
<
    MKMapViewDelegate
>

@property (nonatomic, weak) MKMapView *mapView;

- (instancetype)initWithPlace:(MTMappedPlace *)place NS_DESIGNATED_INITIALIZER;

@end
