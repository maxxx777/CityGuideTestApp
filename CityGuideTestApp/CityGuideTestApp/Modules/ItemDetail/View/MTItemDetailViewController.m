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

@interface MTItemDetailViewController ()

@property (nonatomic, strong) MTPlaceAnnotation *placeAnnotation;

@end

@implementation MTItemDetailViewController
@synthesize presenter = _presenter;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.presenter onDidLoadView];
}

#pragma mark - MTItemDetailViewInterface

- (void)configureNavigationBarWithTitle:(NSString *)title
{
    self.navigationItem.title = title;
}

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

- (void)enableDropPinOnMapView
{
    UILongPressGestureRecognizer *dropPinGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self
                                                                              action:@selector(handleDropPin:)];
    dropPinGestureRecognizer.minimumPressDuration = 1.0; //user needs to press for 1 second
    [self.mapView addGestureRecognizer:dropPinGestureRecognizer];
}

- (void)disableDropPinOnMapView
{
    for (UIGestureRecognizer *gestureRecognizer in [self.mapView gestureRecognizers]) {
        [self.mapView removeGestureRecognizer:gestureRecognizer];
    }
}

- (void)closeView
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - IB Actions

- (IBAction)saveButtonPressed:(id)sender
{
    [self.presenter onDidPressRightBarButtonOnNavigationBar];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if([string isEqualToString:@"\n"]){
        
        [self.textFieldName endEditing:YES];
        
        return NO;
    } else {
        
        [self.presenter onDidChangeTextFieldName:textField.text];
    }
    
    return YES;
}

#pragma mark - UITextViewDelegate

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if([text isEqualToString:@"\n"]){
        
        [self.textViewDescription endEditing:YES];
        
        return NO;
    } else {
        
        [self.presenter onDidChangeTextViewDescription:textView.text];
    }
    
    return YES;
}

#pragma mark - Helper

- (void)handleDropPin:(UIGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer.state != UIGestureRecognizerStateBegan)
        return;
    
    CGPoint touchPoint = [gestureRecognizer locationInView:self.mapView];
    CLLocationCoordinate2D touchMapCoordinate =
    [self.mapView convertPoint:touchPoint toCoordinateFromView:self.mapView];
    
    if (self.placeAnnotation) {
        [self.mapView removeAnnotation:self.placeAnnotation];
        _placeAnnotation = nil;
    }
    _placeAnnotation = [[MTPlaceAnnotation alloc] initWithCoordinate:touchMapCoordinate];
    [self.mapView addAnnotation:self.placeAnnotation];
    
    [self.presenter onDidChangeMapCoordinates:@{
                                           @"latitude" : @(touchMapCoordinate.latitude),
                                           @"longitude" : @(touchMapCoordinate.longitude)
                                           }];
}

@end
