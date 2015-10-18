//
//  MTRootCell.m
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 07.10.15.
//  Copyright (c) 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTRootTableViewCell.h"

@implementation MTRootTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style
                reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self.contentView setTranslatesAutoresizingMaskIntoConstraints:NO];
        
        UIView *contentView = self.contentView;
        
        [self addConstraints:[NSLayoutConstraint
                              constraintsWithVisualFormat:@"V:|[contentView]|"
                              options:NSLayoutFormatDirectionLeadingToTrailing
                              metrics:nil
                              views:NSDictionaryOfVariableBindings(contentView)]];
        [self addConstraints:[NSLayoutConstraint
                              constraintsWithVisualFormat:@"H:|[contentView]|"
                              options:NSLayoutFormatDirectionLeadingToTrailing
                              metrics:nil
                              views:NSDictionaryOfVariableBindings(contentView)]];
    }
    
    return self;
}

@end
