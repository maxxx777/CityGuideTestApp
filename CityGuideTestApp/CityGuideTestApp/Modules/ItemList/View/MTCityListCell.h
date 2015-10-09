//
//  MTItemListCell.h
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 07.10.15.
//  Copyright (c) 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTRootCell.h"

@interface MTCityListCell : MTRootCell

- (void)configureCellWithItem:(id)item
                     isOpened:(BOOL)isOpened;

@end
