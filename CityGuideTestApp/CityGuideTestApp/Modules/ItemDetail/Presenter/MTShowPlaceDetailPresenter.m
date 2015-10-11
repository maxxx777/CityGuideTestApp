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
#import "MTImageManager.h"

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

- (void)onDidLoadView
{
    [self.userInterface configureNavigationBarWithTitle:NSLocalizedString(@"Place", nil)];
    
    NSString *placeName = [self.placeDetailFetcher placeName] ? [self.placeDetailFetcher placeName] : @"";
    [self.userInterface configureNameWithText:[NSString stringWithFormat:@"%@", placeName]];
    
    NSString *placeDescription = [self.placeDetailFetcher placeDescription] ? [self.placeDetailFetcher placeDescription] : @"";
    [self.userInterface configureDescriptionWithText:placeDescription];
    
    if ([self.placeDetailFetcher filePath]) {
        [self.userInterface configureImageWithFilePath:[self.placeDetailFetcher filePath]];
    } else {
        if ([self.placeDetailFetcher photoURL]) {
            
            [self.userInterface enableActivityForImageLoading];
            
            MTImageManager *imageManager = [[MTImageManager alloc] init];
            [imageManager loadImageFromURL:[self.placeDetailFetcher photoURL]
                                completion:^(NSError *error, UIImage *image, NSString *filePath){
                                    [self.userInterface configureImageWithFilePath:filePath];
                                    [self.userInterface disableActivityForImageLoading];
            }];
        } else {
            [self.userInterface configureImageWithPlaceholder];
        }
    }
    
    [self.userInterface configureMapWithCoordinates:[self.placeDetailFetcher placeCoordinates]];
}

@end
