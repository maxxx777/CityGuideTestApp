//
//  MTRootCell.h
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 07.10.15.
//  Copyright (c) 2015 MAXIM TSVETKOV. All rights reserved.
//

@interface MTRootCell : UITableViewCell

- (void)configureCellForOffScreenWithItem:(id)item;
- (CGFloat)heightForCellWithItem:(id)item;

@end
