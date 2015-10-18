//
//  MTPlaceListCollectionViewCell.m
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 16.10.15.
//  Copyright © 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTPlaceListCollectionViewCell.h"
#import "MTMappedPlace.h"

@interface MTPlaceListCollectionViewCell ()

@property (nonatomic, strong) UIImageView *imageViewPhoto;
@property (nonatomic, strong) UILabel *labelName;
@property (nonatomic, strong) UIView *viewName;
@property (nonatomic, strong) MTMappedPlace *mappedPlace;

@end

@implementation MTPlaceListCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor groupTableViewBackgroundColor];
        
        _imageViewPhoto = [[UIImageView alloc] init];
        self.imageViewPhoto.backgroundColor = [UIColor colorWithWhite:0.9f alpha:1.0f];
        self.imageViewPhoto.contentMode = UIViewContentModeScaleAspectFill;
        self.imageViewPhoto.clipsToBounds = YES;
        
        _viewName = [[UIView alloc] init];
        self.viewName.backgroundColor = [UIColor colorWithWhite:0.9f alpha:1.0f];
        
        _labelName = [[UILabel alloc] init];
        self.labelName.font = [UIFont fontWithName:@"ArialMT" size:16.0f];
        self.labelName.numberOfLines = 2;
        self.labelName.textAlignment = NSTextAlignmentCenter;
        self.labelName.backgroundColor = [UIColor colorWithWhite:0.9f alpha:1.0f];
        
        [self.contentView addSubview:self.viewName];
        [self.viewName addSubview:self.labelName];
        [self.contentView addSubview:self.imageViewPhoto];
        
        [self.viewName setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.labelName setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.imageViewPhoto setTranslatesAutoresizingMaskIntoConstraints:NO];
        
        UIView *imageView = self.imageViewPhoto;
        UIView *labelName = self.labelName;
        UIView *viewName = self.viewName;
        
        [self.contentView addConstraints:[NSLayoutConstraint
                                          constraintsWithVisualFormat:@"V:|-30-[imageView(==150)]-0-[viewName]-30-|"
                                          options:NSLayoutFormatDirectionLeadingToTrailing
                                          metrics:nil
                                          views:NSDictionaryOfVariableBindings(imageView, viewName)]];
        [self.contentView addConstraints:[NSLayoutConstraint
                                          constraintsWithVisualFormat:@"H:|-30-[imageView]-30-|"
                                          options:NSLayoutFormatDirectionLeadingToTrailing
                                          metrics:nil
                                          views:NSDictionaryOfVariableBindings(imageView)]];
        [self.contentView addConstraints:[NSLayoutConstraint
                                          constraintsWithVisualFormat:@"H:|-30-[viewName]-30-|"
                                          options:NSLayoutFormatDirectionLeadingToTrailing
                                          metrics:nil
                                          views:NSDictionaryOfVariableBindings(viewName)]];
        [self.viewName addConstraints:[NSLayoutConstraint
                                       constraintsWithVisualFormat:@"H:|-10-[labelName]-10-|"
                                       options:NSLayoutFormatDirectionLeadingToTrailing
                                       metrics:nil
                                       views:NSDictionaryOfVariableBindings(labelName)]];
        [self.viewName addConstraints:[NSLayoutConstraint
                                       constraintsWithVisualFormat:@"V:|-0-[labelName]-0-|"
                                       options:NSLayoutFormatDirectionLeadingToTrailing
                                       metrics:nil
                                       views:NSDictionaryOfVariableBindings(labelName)]];
    }
    return self;
}

@end
