//
//  MTCityListCollectionViewCell.m
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 16.10.15.
//  Copyright © 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTCityListCollectionViewCell.h"

@interface MTCityListCollectionViewCell ()

@property (nonatomic, strong) UIImageView *imageViewDisclosure;
@property (nonatomic, strong) UILabel *textLabel;

@end

@implementation MTCityListCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor groupTableViewBackgroundColor];
        
        _textLabel = [[UILabel alloc] init];
        self.textLabel.font = [UIFont fontWithName:@"Arial-BoldMT" size:16.0f];
        
        _imageViewDisclosure = [[UIImageView alloc] init];
        (self.imageViewDisclosure).image = [UIImage imageNamed:@"disclosure.png"];
        
        [self.contentView addSubview:self.textLabel];
        [self.contentView addSubview:self.imageViewDisclosure];
        
        UIView *textLabel = self.textLabel;
        UIView *disclosureImageView = self.imageViewDisclosure;
        
        [self.textLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.imageViewDisclosure setTranslatesAutoresizingMaskIntoConstraints:NO];
        
        [self.contentView addConstraints:[NSLayoutConstraint
                                          constraintsWithVisualFormat:@"H:|-10-[textLabel]-10-[disclosureImageView(==13)]-10-|"
                                          options:NSLayoutFormatDirectionLeadingToTrailing
                                          metrics:nil
                                          views:NSDictionaryOfVariableBindings(textLabel, disclosureImageView)]];
        [self.contentView addConstraints:[NSLayoutConstraint
                                          constraintsWithVisualFormat:@"V:|-12-[disclosureImageView(==20)]-12-|"
                                          options:NSLayoutFormatDirectionLeadingToTrailing
                                          metrics:nil
                                          views:NSDictionaryOfVariableBindings(disclosureImageView)]];
        [self.contentView addConstraints:[NSLayoutConstraint
                                          constraintsWithVisualFormat:@"V:|-5-[textLabel]-5-|"
                                          options:NSLayoutFormatDirectionLeadingToTrailing
                                          metrics:nil
                                          views:NSDictionaryOfVariableBindings(textLabel)]];
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}

- (void)setSelected:(BOOL)selected
{
    [self mt_animateImageViewDisclosureTransfromationWithState:selected
                                                      duration:0.3f];
}

@end
