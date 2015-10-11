//
//  MTShowPlaceDetailPresenter.m
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 10.10.15.
//  Copyright © 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTEditPlaceDetailPresenter.h"
#import "MTItemDetailWireframe.h"
#import "MTItemDetailViewInterface.h"
#import "MTLocationManager.h"

@interface MTEditPlaceDetailPresenter ()

@property (nonatomic, strong) id<MTPlaceDetailConfiguratorInputInterface>placeDetailConfigurator;
@property (nonatomic, strong) id<MTItemOperatorInputInterface>itemOperator;
@property (nonatomic, weak) MTItemDetailWireframe *wireframe;

@end

@implementation MTEditPlaceDetailPresenter

- (instancetype)initWithPlaceDetailConfigurator:(id<MTPlaceDetailConfiguratorInputInterface>)placeDetailConfigurator
                                   itemOperator:(id<MTItemOperatorInputInterface>)itemOperator
                                      wireframe:(MTItemDetailWireframe *)wireframe
{
    self = [super init];
    if (self) {
        
        _placeDetailConfigurator = placeDetailConfigurator;
        _itemOperator = itemOperator;
        _wireframe = wireframe;
        
    }
    return self;
}

#pragma mark - MTItemDetailPresenterInterface

- (void)onDidLoadView
{
    [self.userInterface configureNavigationBarWithTitle:NSLocalizedString(@"New Place", nil)];
    
    NSString *placeName = [self.placeDetailConfigurator placeName] ? [self.placeDetailConfigurator placeName] : @"";
    [self.userInterface configureNameWithText:[NSString stringWithFormat:@"%@", placeName]];
    
    NSString *placeDescription = [self.placeDetailConfigurator placeDescription] ? [self.placeDetailConfigurator placeDescription] : @"";
    [self.userInterface configureDescriptionWithText:placeDescription];
    
//    [self.userInterface configureImageWithURL:[self.placeDetailConfigurator photoURL]];
    
//    if ([[MTLocationManager sharedManager] isCurrentLocationDetected]) {
//        [self.userInterface configureMapWithCoordinates:[[MTLocationManager sharedManager] currentLocation]];
//    }
    
    [self.userInterface enableDropPinOnMapView];
}

- (void)onDidChangeMapCoordinates:(NSDictionary *)coordinates
{
    [self.placeDetailConfigurator configurePlaceCoordinates:coordinates];
}

- (void)onDidChangeTextFieldName:(NSString *)name
{
    [self.placeDetailConfigurator configurePlaceName:name];
}

- (void)onDidChangeTextViewDescription:(NSString *)description
{
    [self.placeDetailConfigurator configurePlaceDescription:description];
}

- (void)onDidPressRightBarButtonOnNavigationBar
{
    [self.itemOperator saveItem:[self.placeDetailConfigurator currentItem]];
}

#pragma mark - MTItemOperatorOutputInterface

- (void)onDidSaveItem
{
    [self.userInterface closeView];
}

@end
