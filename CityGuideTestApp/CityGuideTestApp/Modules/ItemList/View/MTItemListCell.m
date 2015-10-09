//
//  MTItemListCell.m
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 07.10.15.
//  Copyright (c) 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTItemListCell.h"
#import "MTMappedCity.h"
#import "MTMappedPlace.h"

@implementation MTItemListCell

- (void)layoutSubviews
{
    [super layoutSubviews];
}

- (void)configureCellWithItem:(id)item
{
    if ([item isKindOfClass:[MTMappedCity class]]) {
        self.backgroundColor = [UIColor redColor];
    } else {
        self.backgroundColor = [UIColor greenColor];
    }
    self.textLabel.text = [item valueForKey:@"itemName"];
}

- (void)configureCellWithItem:(id)item
                    isChecked:(BOOL)isChecked
{
    [self setChecked:isChecked];
}

- (void)configureCellForOffScreenWithItem:(id)item
{
    //
}

- (void)setChecked:(BOOL)checked
{
    if (checked) {
        self.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        self.accessoryType = UITableViewCellAccessoryNone;
    }
}

- (CGFloat)heightForCellWithItem:(id)item
{
    return UITableViewAutomaticDimension;
}

- (CGFloat)heightForCellWithItem:(id)item
                  hasIndexedList:(BOOL)hasIndexedList
{
    return UITableViewAutomaticDimension;
}

@end
