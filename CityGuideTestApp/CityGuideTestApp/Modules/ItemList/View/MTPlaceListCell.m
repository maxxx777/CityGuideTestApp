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
        
        [self.contentView addSubview:self.imageViewPhoto];
        [self.contentView addSubview:self.labelName];
        
        UIView *imageView = self.imageViewPhoto;
        UIView *labelName = self.labelName;
        [self.imageViewPhoto setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.labelName setTranslatesAutoresizingMaskIntoConstraints:NO];
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
        if (mappedPlace.imageUrl) {
            
            [self.imageViewPhoto mt_startActivityAnimation];
            
            MTImageManager *imageManager = [[MTImageManager alloc] init];
            [imageManager loadImageFromURL:[NSURL URLWithString:mappedPlace.imageUrl]
                                completion:^(NSError *error, UIImage *image, NSString *filePath){
                                    self.imageViewPhoto.image = image;
                                    
                                    [self.imageViewPhoto mt_stopActivityAnimation];
                                       }];
        } else {
            UIImage *image = [UIImage imageNamed:@"image_placeholder.png"];
            [self.imageViewPhoto setImage:image];
        }
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
