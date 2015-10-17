//
//  UIView+MTCityListCell.m
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 16.10.15.
//  Copyright © 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "UIView+MTCityListCell.h"
#import "MTMappedCity.h"
#import "UIImageView+MTEditing.h"

@implementation UIView (MTCityListCell)
@dynamic textLabel;
@dynamic imageViewDisclosure;

#pragma mark - Public

- (void)mt_configureCellWithItem:(id)item
                        isOpened:(BOOL)isOpened
{
    MTMappedCity *mappedCity = (MTMappedCity *)item;
    
    self.textLabel.text = mappedCity.itemName;
    
    [self mt_animateImageViewDisclosureTransfromationWithState:isOpened
                                                      duration:0.0f];
}

- (void)mt_animateImageViewDisclosureTransfromationWithState:(BOOL)isTransfromed
                                                    duration:(NSTimeInterval)duration
{
    [UIView animateWithDuration:duration
                     animations:^(){
                         [self mt_transformImageViewDisclosureWithState:isTransfromed];
                     }];
}

#pragma mark - Helper

- (void)mt_transformImageViewDisclosureWithState:(BOOL)isTransfromed
{
    if (isTransfromed) {
        [self.imageViewDisclosure mt_transformImageWithRotation:M_PI_2];
    } else {
        [self.imageViewDisclosure mt_transformImageWithRotation:0];
    }
}

@end
