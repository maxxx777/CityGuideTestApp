//
//  UIView+MTCityListCell.h
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 16.10.15.
//  Copyright © 2015 MAXIM TSVETKOV. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (MTCityListCell)

@property (nonatomic, weak) UILabel *textLabel;
@property (nonatomic, strong) UIImageView *imageViewDisclosure;

- (void)mt_configureCellWithItem:(id _Nonnull)item
                        isOpened:(BOOL)isOpened;
- (void)mt_animateImageViewDisclosureTransfromationWithState:(BOOL)isTransfromed
                                                    duration:(NSTimeInterval)duration;

@end
