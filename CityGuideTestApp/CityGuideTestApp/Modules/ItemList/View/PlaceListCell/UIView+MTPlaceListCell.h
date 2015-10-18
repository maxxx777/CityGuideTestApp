//
//  UIView+MTPlaceListCell.h
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 16.10.15.
//  Copyright © 2015 MAXIM TSVETKOV. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MTImageManagerDelegate.h"

@class MTMappedPlace;

@interface UIView (MTPlaceListCell)
<
    MTImageManagerDelegate
>

@property (nonatomic, strong) UIImageView *imageViewPhoto;
@property (nonatomic, strong) UILabel *labelName;
@property (nonatomic, strong) MTMappedPlace *mappedPlace;

- (void)mt_configureCellWithItem:(id _Nonnull)item;

@end
