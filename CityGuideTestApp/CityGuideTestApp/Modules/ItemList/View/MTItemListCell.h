//
//  MTItemListCell.h
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 07.10.15.
//  Copyright (c) 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTRootCell.h"

@interface MTItemListCell : MTRootCell

@property (nonatomic, getter=isChecked) BOOL checked;

- (void)configureCellWithItem:(id)item;
- (void)configureCellWithItem:(id)item
                    isChecked:(BOOL)isChecked;
- (void)configureCellForOffScreenWithItem:(id)item;
- (CGFloat)heightForCellWithItem:(id)item;
- (CGFloat)heightForCellWithItem:(id)item
                  hasIndexedList:(BOOL)hasIndexedList;

@end
