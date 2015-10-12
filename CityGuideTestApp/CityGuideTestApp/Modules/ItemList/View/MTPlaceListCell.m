//
//  MTItemListCell.m
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 07.10.15.
//  Copyright (c) 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTPlaceListCell.h"
#import "MTMappedPlace.h"
#import "UIImageView+MTActivityAnimation.h"
#import "MTImageManager.h"

@interface MTPlaceListCell ()

@property (nonatomic, strong) UIImageView *imageViewPhoto;
@property (nonatomic, strong) UILabel *labelName;
@property (nonatomic, strong) UIView *viewLine;

@end

@implementation MTPlaceListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style
                reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        _imageViewPhoto = [[UIImageView alloc] init];
        self.imageViewPhoto.contentMode = UIViewContentModeScaleAspectFill;
        self.imageViewPhoto.clipsToBounds = YES;
        
        _labelName = [[UILabel alloc] init];
        self.labelName.font = [UIFont fontWithName:@"ArialMT" size:16.0f];
        self.labelName.numberOfLines = 0;
        
        _viewLine = [[UIView alloc] init];
        self.viewLine.backgroundColor = [UIColor groupTableViewBackgroundColor];
        
        [self.contentView addSubview:self.imageViewPhoto];
        [self.contentView addSubview:self.labelName];
        [self.contentView addSubview:self.viewLine];
        
        UIView *imageView = self.imageViewPhoto;
        UIView *labelName = self.labelName;
        UIView *viewLine = self.viewLine;
        [self.imageViewPhoto setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.labelName setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.viewLine setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.contentView addConstraints:[NSLayoutConstraint
                                          constraintsWithVisualFormat:@"H:|-5-[imageView(==50)]-5-[labelName]-5-|"
                                          options:NSLayoutFormatDirectionLeadingToTrailing
                                          metrics:nil
                                          views:NSDictionaryOfVariableBindings(imageView, labelName)]];
        [self.contentView addConstraints:[NSLayoutConstraint
                                          constraintsWithVisualFormat:@"V:|-5-[imageView]-5-|"
                                          options:NSLayoutFormatDirectionLeadingToTrailing
                                          metrics:nil
                                          views:NSDictionaryOfVariableBindings(imageView)]];
        [self.contentView addConstraints:[NSLayoutConstraint
                                          constraintsWithVisualFormat:@"V:|-5-[labelName]-5-|"
                                          options:NSLayoutFormatDirectionLeadingToTrailing
                                          metrics:nil
                                          views:NSDictionaryOfVariableBindings(labelName)]];
        [self.contentView addConstraints:[NSLayoutConstraint
                                          constraintsWithVisualFormat:@"H:|-0-[viewLine]-(-33)-|"
                                          options:NSLayoutFormatDirectionLeadingToTrailing
                                          metrics:nil
                                          views:NSDictionaryOfVariableBindings(viewLine)]];
        [self.contentView addConstraints:[NSLayoutConstraint
                                          constraintsWithVisualFormat:@"V:[viewLine(==1)]-0-|"
                                          options:NSLayoutFormatDirectionLeadingToTrailing
                                          metrics:nil
                                          views:NSDictionaryOfVariableBindings(viewLine)]];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
}

- (void)configureCellWithItem:(id)item
{
    MTMappedPlace *mappedPlace = (MTMappedPlace *)item;
    
    self.labelName.text = mappedPlace.itemName;
    
    if (mappedPlace.filePath) {
        UIImage *image = [UIImage imageWithContentsOfFile:mappedPlace.filePath];
        [self.imageViewPhoto setImage:image];
    } else {
        [self.imageViewPhoto mt_startActivityAnimation];
        [[MTImageManager sharedManager] fetchImageForPlace:mappedPlace
                                                completion:^(NSError *error, NSString *filePath){

                                                    UIImage *image;
                                                    if (filePath) {
                                                        image = [UIImage imageWithContentsOfFile:filePath];
                                                    } else {
                                                        image = [UIImage imageNamed:@"image_placeholder.png"];
                                                    }
                                                    [self.imageViewPhoto setImage:image];
                                                    
                                                    [self.imageViewPhoto mt_stopActivityAnimation];
        }];
    }
}

- (void)configureCellForOffScreenWithItem:(id)item
{
    //
}

- (CGFloat)heightForCellWithItem:(id)item
{
    return 60.0f;
}

@end
