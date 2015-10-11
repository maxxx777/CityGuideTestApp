//
//  MTItemDetailViewController.m
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 10.10.15.
//  Copyright © 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTItemDetailViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "MTPlaceAnnotation.h"

@implementation MTItemDetailViewController
@synthesize presenter = _presenter;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.presenter configureView];
}

#pragma mark - MTItemDetailViewInterface

- (void)configureNameWithText:(NSString *)text
{
    self.textFieldName.text = text;
}

- (void)configureDescriptionWithText:(NSString *)text
{
    self.textViewDescription.text = text;
}

- (void)configureMapWithCoordinates:(NSDictionary *)coordinates
{
    CLLocationCoordinate2D center = CLLocationCoordinate2DMake([[coordinates valueForKey:@"latitude"] doubleValue], [[coordinates valueForKey:@"longitude"] doubleValue]);
    
    MKCoordinateRegion region;
    MKCoordinateSpan span;
    span.latitudeDelta = 0.006;
    span.longitudeDelta = 0.006;
    
    region.span = span;
    region.center = center;
    
    MTPlaceAnnotation *placeAnnotation = [[MTPlaceAnnotation alloc] initWithCoordinate:center];
    [self.mapView addAnnotation:placeAnnotation];
    
    [self.mapView setRegion:region animated:YES];
    [self.mapView regionThatFits:region];
}

- (void)configureImageWithURL:(NSURL *)url
{
    __block UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    activityIndicator.hidesWhenStopped = YES;
    
    [self.imageViewPhoto addSubview:activityIndicator];
    [activityIndicator startAnimating];
    
    [activityIndicator setTranslatesAutoresizingMaskIntoConstraints:NO];
    NSLayoutConstraint *heightConstraint =
    [NSLayoutConstraint constraintWithItem:self.imageViewPhoto
                                 attribute:NSLayoutAttributeCenterX
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:activityIndicator
                                 attribute:NSLayoutAttributeCenterX
                                multiplier:1.0
                                  constant:0];
    [self.photoCell.contentView addConstraint:heightConstraint];
    
    NSLayoutConstraint *widthConstraint =
    [NSLayoutConstraint constraintWithItem:self.imageViewPhoto
                                 attribute:NSLayoutAttributeCenterY
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:activityIndicator
                                 attribute:NSLayoutAttributeCenterY
                                multiplier:1.0
                                  constant:0];
    [self.photoCell.contentView addConstraint:widthConstraint];
    
    [self.imageViewPhoto sd_setImageWithURL:url
                           placeholderImage:nil
                                    options:SDWebImageRetryFailed
                                  completed:^(UIImage *image,
                                              NSError *error,
                                              SDImageCacheType cacheType,
                                              NSURL *imageURL){
                                      [activityIndicator removeFromSuperview];
                                  }];
}

@end
