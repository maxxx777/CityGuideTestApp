//
//  MTItemListCell.m
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 07.10.15.
//  Copyright (c) 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTCityListCell.h"
#import "MTMappedCity.h"

@interface MTCityListCell ()

@property (nonatomic) BOOL isOpened;
@property (nonatomic, strong) UIImageView *imageViewDisclosure;

@end

@implementation MTCityListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style
                reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _imageViewDisclosure = [[UIImageView alloc] init];
        [self.imageViewDisclosure setImage:[UIImage imageNamed:@"disclosure.png"]];
        
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
        
        _isOpened = NO;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.textLabel.font = [UIFont fontWithName:@"Arial-BoldMT" size:16.0f];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (_isOpened) {
        CGAffineTransform transform = CGAffineTransformMakeRotation(M_PI_2);
        self.imageViewDisclosure.transform = transform;
    } else {
        CGAffineTransform transform = CGAffineTransformMakeRotation(0);
        self.imageViewDisclosure.transform = transform;
    }
    
//    self.accessoryView = disclosureImageView;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    if (selected) {
        _isOpened = !self.isOpened;
        
        __block BOOL isOpenedNow = self.isOpened;
        
        [UIView animateWithDuration:0.3f
                         animations:^(){
                             if (isOpenedNow) {
                                 CGAffineTransform transform = CGAffineTransformMakeRotation(M_PI_2);
                                 self.imageViewDisclosure.transform = transform;
                             } else {
                                 CGAffineTransform transform = CGAffineTransformMakeRotation(0);
                                 self.imageViewDisclosure.transform = transform;                                 
                             }
        }];
    }
}

- (void)configureCellWithItem:(id)item
                     isOpened:(BOOL)isOpened
{
    MTMappedCity *mappedCity = (MTMappedCity *)item;
    _isOpened = isOpened;
    
    self.textLabel.text = mappedCity.itemName;
}

- (void)configureCellForOffScreenWithItem:(id)item
{
    //
}

- (CGFloat)heightForCellWithItem:(id)item
{
    return 44.0f;
}

@end
