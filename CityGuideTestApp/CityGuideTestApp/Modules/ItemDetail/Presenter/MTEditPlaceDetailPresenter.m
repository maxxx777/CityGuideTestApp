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

- (void)configureView
{
    [self.userInterface configureNavigationBarWithTitle:NSLocalizedString(@"New Place", nil)];
    
    NSString *placeName = [self.placeDetailConfigurator placeName] ? [self.placeDetailConfigurator placeName] : @"";
    [self.userInterface configureNameWithText:[NSString stringWithFormat:@"%@", placeName]];
    
    NSString *placeDescription = [self.placeDetailConfigurator placeDescription] ? [self.placeDetailConfigurator placeDescription] : @"";
    [self.userInterface configureDescriptionWithText:placeDescription];
    
//    [self.userInterface configureImageWithURL:[self.placeDetailConfigurator photoURL]];
//    [self.userInterface configureMapWithCoordinates:[self.placeDetailConfigurator placeCoordinates]];
}

@end
