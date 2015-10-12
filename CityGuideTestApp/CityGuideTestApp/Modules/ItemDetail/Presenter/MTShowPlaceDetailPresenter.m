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
            
            
            
            if ([self.placeDetailFetcher filePath]) {
                [self.userInterface configureImageWithFilePath:[self.placeDetailFetcher filePath]];
            } else {
                __weak __typeof(self)weakSelf = self;
                [self.userInterface enableActivityForImageLoading];
                [[MTImageManager sharedManager] fetchImageForPlace:[self.placeDetailFetcher currentItem]
                                                        completion:^(NSError *error, NSString *filePath){
                                                            if (filePath) {
                                                                [weakSelf.placeDetailFetcher refreshCurrentItem];
                                                            } else {
                                                                [weakSelf.userInterface configureImageWithPlaceholder];
                                                            }
                                                            [weakSelf.userInterface disableActivityForImageLoading];
                                                        }];
            }
            
        } else {
            [self.userInterface configureImageWithPlaceholder];
        }
    }
    
    [self.userInterface configureMapWithCoordinates:[self.placeDetailFetcher placeCoordinates]];
}

- (void)onDidSelectImageCell
{
    [self.wireframe onDidSelectImage:[self.userInterface imagePhoto]];
}

#pragma mark - MTPlaceDetailFetcherOutputInterface

- (void)onDidRefreshCurrentItem
{
    [self.userInterface configureImageWithFilePath:[self.placeDetailFetcher filePath]];
}

@end
