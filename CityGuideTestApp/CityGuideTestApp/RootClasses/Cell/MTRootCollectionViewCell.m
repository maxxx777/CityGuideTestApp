//
//  MTRootCollectionViewCell.m
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 16.10.15.
//  Copyright © 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTRootCollectionViewCell.h"

@implementation MTRootCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
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
