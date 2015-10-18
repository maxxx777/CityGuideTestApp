//
//  UIView+MTPlaceListCell.m
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 16.10.15.
//  Copyright © 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "UIView+MTPlaceListCell.h"
#import "MTMappedPlace.h"
#import "MTImageCache.h"
#import "UIImage+MTEditing.h"
#import "UIImageView+MTActivityAnimation.h"
#import "MTImageManager.h"

@implementation UIView (MTPlaceListCell)
@dynamic imageViewPhoto;
@dynamic labelName;
@dynamic mappedPlace;

- (void)mt_configureCellWithItem:(id)item
{
    self.mappedPlace = (MTMappedPlace *)item;
    
    self.labelName.text = self.mappedPlace.itemName;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        UIImage *image = [[MTImageCache sharedCache] imageFromCacheForPlace:self.mappedPlace];
        if (image) {
            
            image = [image mt_resizeToSize:self.imageViewPhoto.frame.size];
            
            dispatch_sync(dispatch_get_main_queue(), ^{
                (self.imageViewPhoto).image = image;
            });
            
        } else {
            dispatch_sync(dispatch_get_main_queue(), ^{
                [self.imageViewPhoto setImage:nil];
                [self.imageViewPhoto mt_startActivityAnimation];
                [[MTImageManager sharedManager] fetchImageForPlace:self.mappedPlace
                                                          delegate:self];
            });
        }
    });
}

#pragma mark - MTImageManagerDelegate

- (void)onDidFetchImageForPlace:(id)place error:(NSError *)error
{
    [self.imageViewPhoto mt_stopActivityAnimation];
    
    if (place) {
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
            BOOL isCurrentPlaceWithFetchedImage = NO;
            if (place && self.mappedPlace) {
                MTMappedPlace *placeWithFetchedImage = (MTMappedPlace *)place;
                isCurrentPlaceWithFetchedImage = [placeWithFetchedImage.itemId isEqualToNumber:self.mappedPlace.itemId];
            }
            
            if (isCurrentPlaceWithFetchedImage) {
                
                UIImage *image = [[MTImageCache sharedCache] imageFromCacheForPlace:place];
                if (image) {
                    
                    if (image.size.height > image.size.width) {
                        
                        CGFloat scaledHeight = image.size.height * CGRectGetWidth(self.imageViewPhoto.frame) / image.size.width;
                        CGSize scaledSize = CGSizeMake(CGRectGetWidth(self.imageViewPhoto.frame), scaledHeight);
                        
                        image = [image mt_resizeToSize:scaledSize];
                        
                        CGRect cropRect = CGRectMake(0,
                                                     (image.size.height - CGRectGetHeight(self.imageViewPhoto.frame)) / 2,
                                                     image.size.width,
                                                     image.size.height);
                        
                        image = [image mt_cropToRect:cropRect];
                        
                    } else {
                        
                        CGFloat scaledWidth = image.size.width * CGRectGetHeight(self.imageViewPhoto.frame) / image.size.height;
                        CGSize scaledSize = CGSizeMake(scaledWidth, CGRectGetHeight(self.imageViewPhoto.frame));
                        
                        image = [image mt_resizeToSize:scaledSize];
                        
                        CGRect cropRect = CGRectMake((image.size.width - CGRectGetWidth(self.imageViewPhoto.frame)) / 2,
                                                     0,
                                                     image.size.width,
                                                     image.size.height);
                        
                        image = [image mt_cropToRect:cropRect];
                        
                    }
                    
                } else {
                    image = [UIImage imageNamed:@"image_placeholder.png"];
                }
                dispatch_sync(dispatch_get_main_queue(), ^{
                    (self.imageViewPhoto).image = image;
                });
            }
        });
    }
}

@end
