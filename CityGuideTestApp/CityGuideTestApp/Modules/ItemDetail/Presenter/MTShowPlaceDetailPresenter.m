//
//  MTShowPlaceDetailPresenter.m
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 10.10.15.
//  Copyright © 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTShowPlaceDetailPresenter.h"
#import "MTItemDetailWireframe.h"
#import "MTItemDetailViewInterface.h"

@interface MTShowPlaceDetailPresenter ()

@property (nonatomic, strong) id<MTPlaceDetailFetcherInputInterface>placeDetailFetcher;
@property (nonatomic, weak) MTItemDetailWireframe *wireframe;

@end

@implementation MTShowPlaceDetailPresenter

- (instancetype)initWithPlaceDetailFetcher:(id<MTPlaceDetailFetcherInputInterface>)placeDetailFetcher
                                 wireframe:(MTItemDetailWireframe *)wireframe
{
    self = [super init];
    if (self) {
        
        _placeDetailFetcher = placeDetailFetcher;
        _wireframe = wireframe;
        
    }
    return self;
}

#pragma mark - MTShowPlaceDetailPresenterInterface

- (void)configureView
{
    [self.userInterface configureNavigationBarWithTitle:NSLocalizedString(@"Place", nil)];
    
    NSString *placeName = [self.placeDetailFetcher placeName];
    NSString *cityName = [self.placeDetailFetcher cityName];
    [self.userInterface configureNameWithText:[NSString stringWithFormat:@"%@ (%@)", placeName, cityName]];
    [self.userInterface configureDescriptionWithText:[self.placeDetailFetcher placeDescription]];
    [self.userInterface configureImageWithURL:[self.placeDetailFetcher photoURL]];
    [self.userInterface configureMapWithCoordinates:[self.placeDetailFetcher placeCoordinates]];
}

@end
