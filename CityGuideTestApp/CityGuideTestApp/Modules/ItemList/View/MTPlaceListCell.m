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
#import "NSString+MTFormatting.h"
#import "MTImageCache.h"
#import "UIImage+MTEditing.h"

@interface MTPlaceListCell ()

@property (nonatomic, strong) UIImageView *imageViewPhoto;
@property (nonatomic, strong) UILabel *labelName;
@property (nonatomic, strong) UIView *viewLine;
@property (nonatomic, strong) MTMappedPlace *mappedPlace;

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
        self.labelName.backgroundColor = [UIColor whiteColor];
        
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
    _mappedPlace = (MTMappedPlace *)item;
    
    self.labelName.text = self.mappedPlace.itemName;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        UIImage *image = [[MTImageCache sharedCache] imageFromCacheForPlace:self.mappedPlace];
        if (image) {
        
            image = [image mt_resizeToSize:self.imageViewPhoto.frame.size];
            
            dispatch_sync(dispatch_get_main_queue(), ^{
                (self.imageViewPhoto).image = image;
            });
        
        } else {
            dispatch_sync(dispatch_get_main_queue(), ^{
                [self.imageViewPhoto setImage:nil];
                [self.imageViewPhoto mt_startActivityAnimation];
                [[MTImageManager sharedManager] fetchImageForPlace:self.mappedPlace
                                                          delegate:self];
            });
        }
    });
}

#pragma mark - MTImageManagerDelegate

- (void)onDidFetchImageForPlace:(id)place error:(NSError *)error
{
    [self.imageViewPhoto mt_stopActivityAnimation];
    
    if (place) {
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
            BOOL isCurrentPlaceWithFetchedImage = NO;
            if (place && self.mappedPlace) {
                MTMappedPlace *placeWithFetchedImage = (MTMappedPlace *)place;
                isCurrentPlaceWithFetchedImage = [placeWithFetchedImage.itemId isEqualToNumber:self.mappedPlace.itemId];
            }
            
            if (isCurrentPlaceWithFetchedImage) {
                
                UIImage *image = [[MTImageCache sharedCache] imageFromCacheForPlace:place];
                if (image) {
                    image = [image mt_resizeToSize:self.imageViewPhoto.frame.size];
                } else {
                    image = [UIImage imageNamed:@"image_placeholder.png"];
                }
                dispatch_sync(dispatch_get_main_queue(), ^{
                    (self.imageViewPhoto).image = image;
                });
            }
        });
    }
}

@end
