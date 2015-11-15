//
//  MTShowPlaceDetailPresenter.m
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 10.10.15.
//  Copyright © 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTShowPlaceDetailPresenter.h"
#import "MTItemDetailViewInterface.h"
#import "MTAppRouterInterface.h"
#import "MTImageCache.h"
#import "MTImageManager.h"

@interface MTShowPlaceDetailPresenter ()

@property (nonatomic, strong) id<MTPlaceDetailFetcherInputInterface>placeDetailFetcher;
@property (nonatomic, weak) id<MTAppRouterInterface> router;
@property (nonatomic) BOOL isFirstAppearance;
@property (nonatomic, strong) UIImage *image;

@end

@implementation MTShowPlaceDetailPresenter

- (instancetype)initWithPlaceDetailFetcher:(id<MTPlaceDetailFetcherInputInterface>)placeDetailFetcher
                                    router:(id<MTAppRouterInterface>)router
{
    self = [super init];
    if (self) {
        
        _placeDetailFetcher = placeDetailFetcher;
        _router = router;
        
        _isFirstAppearance = YES;
    }
    return self;
}

- (UIViewController<MTItemDetailViewInterface> *)userInterface
{
    NSAssert(_userInterface != nil, @"userInterface is equal to nil");
    return _userInterface;
}

#pragma mark - MTShowPlaceDetailPresenterInterface

- (void)onWillAppearView
{
    if (self.isFirstAppearance) {
     
        [self.userInterface configureNavigationBarWithTitle:NSLocalizedString(@"Place", nil)];
        
        if (IS_IPAD) {
            [self.userInterface configureLeftBarButtonOnNavigationBarAsClose];
        }
        
        NSString *placeName = [self.placeDetailFetcher placeName] ? [self.placeDetailFetcher placeName] : @"";
        [self.userInterface configureNameWithText:[NSString stringWithFormat:@"%@", placeName]];
        [self.userInterface disableTextField];
        
        NSString *placeDescription = [self.placeDetailFetcher placeDescription] ? [self.placeDetailFetcher placeDescription] : @"";
        [self.userInterface configureDescriptionWithText:placeDescription];
        [self.userInterface disableTextView];
        
    }
}

- (void)onDidAppearView
{
    if (self.isFirstAppearance) {
        
        [self.userInterface reloadCells];
        
        [self.userInterface configureMapWithCoordinates:[self.placeDetailFetcher placeCoordinates]];
        
        if ([self.placeDetailFetcher fileName]) {
            [self.userInterface configureImageWithImage:self.image];
        } else {
            if ([self.placeDetailFetcher photoURL]) {
                
                [self.userInterface enableActivityForImageLoading];
                [[MTImageManager sharedManager] fetchImageForPlace:[self.placeDetailFetcher currentItem]
                                                          delegate:self];
            } else {
                [self.userInterface configurePhotoCellAsNoImage];
            }
        }
        
        self.isFirstAppearance = NO;
    }
}

- (void)onDidSelectImageCellWithRect:(CGRect)rect
{
    if ([self.placeDetailFetcher fileName]) {
        [self.router showImage:self.image
          navigationController:self.userInterface.navigationController];
    }
}

#pragma mark - MTPlaceDetailFetcherOutputInterface

- (void)onDidRefreshCurrentItem
{
    [self.userInterface configureImageWithImage:self.image];
}

#pragma mark - MTImageManagerDelegate

- (void)onDidFetchImageForPlace:(id)place
                          error:(NSError *)error
{
    if (error) {
        [self.userInterface configurePhotoCellAsNoImage];
    } else {
        [self.placeDetailFetcher refreshCurrentItem];
    }
    [self.userInterface disableActivityForImageLoading];
}

#pragma mark - Image

- (UIImage *)image
{
    if (_image) {
        return _image;
    }
    _image = [[MTImageCache sharedCache] imageFromCacheForPlace:[self.placeDetailFetcher currentItem]];
    return _image;
}

@end
