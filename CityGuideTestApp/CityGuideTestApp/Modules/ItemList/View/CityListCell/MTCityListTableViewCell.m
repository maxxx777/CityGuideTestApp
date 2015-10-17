//
//  MTItemListCell.m
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 07.10.15.
//  Copyright (c) 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTCityListTableViewCell.h"

@interface MTCityListTableViewCell ()

@property (nonatomic, strong) UIImageView *imageViewDisclosure;

@end

@implementation MTCityListTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style
                reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor = [UIColor groupTableViewBackgroundColor];
        self.textLabel.font = [UIFont fontWithName:@"Arial-BoldMT" size:16.0f];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _imageViewDisclosure = [[UIImageView alloc] init];
        (self.imageViewDisclosure).image = [UIImage imageNamed:@"disclosure.png"];
        
        [self.contentView addSubview:self.imageViewDisclosure];
        [self.imageViewDisclosure setTranslatesAutoresizingMaskIntoConstraints:NO];
        
        UIView *disclosureImageView = self.imageViewDisclosure;
        [self.contentView addConstraints:[NSLayoutConstraint
                                        constraintsWithVisualFormat:@"H:[disclosureImageView(==13)]-10-|"
                                        options:NSLayoutFormatDirectionLeadingToTrailing
                                        metrics:nil
                                         views:NSDictionaryOfVariableBindings(disclosureImageView)]];
        [self.contentView addConstraints:[NSLayoutConstraint
                                          constraintsWithVisualFormat:@"V:|-12-[disclosureImageView(==20)]-12-|"
                                          options:NSLayoutFormatDirectionLeadingToTrailing
                                          metrics:nil
                                          views:NSDictionaryOfVariableBindings(disclosureImageView)]];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [self mt_animateImageViewDisclosureTransfromationWithState:selected
                                                      duration:0.3f];
}

@end
