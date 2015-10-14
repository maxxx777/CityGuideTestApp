//
//  MTItemListCell.h
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 07.10.15.
//  Copyright (c) 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTRootCell.h"
#import "MTImageManagerDelegate.h"

@interface MTPlaceListCell : MTRootCell
<
    MTImageManagerDelegate
>

- (void)configureCellWithItem:(id)item;

@end
