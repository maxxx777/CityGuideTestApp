//
//  MTItemDetailViewController.m
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 10.10.15.
//  Copyright © 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTItemDetailViewController.h"
#import "MTPlaceAnnotation.h"
#import "MTItemDetailViewConstants.h"
#import "UIImageView+MTActivityAnimation.h"

@interface MTItemDetailViewController ()

@property (nonatomic, strong) MTPlaceAnnotation *placeAnnotation;
@property (nonatomic, strong) UIImagePickerController *imagePicker;

@end

@implementation MTItemDetailViewController
@synthesize presenter = _presenter;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self configureView];
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

- (void)configureImageWithFilePath:(NSString *)filePath
{
    UIImage *image = [UIImage imageWithContentsOfFile:filePath];
    [self.imageViewPhoto setImage:image];
}

- (void)configureImageWithPlaceholder
{
    UIImage *image = [UIImage imageNamed:@"image_placeholder.png"];
    [self.imageViewPhoto setImage:image];
}

- (void)configureRightBarButtonOnNavigationBarAsSave
{
    UIBarButtonItem *saveBarButton = [[UIBarButtonItem alloc]
                                      initWithBarButtonSystemItem:UIBarButtonSystemItemSave
                                      target:self
                                      action:@selector(saveButtonPressed:)];
    self.navigationItem.rightBarButtonItem = saveBarButton;
}

- (void)enableActivityForImageLoading
{
    [self.imageViewPhoto mt_startActivityAnimation];
}

- (void)disableActivityForImageLoading
{
    [self.imageViewPhoto mt_stopActivityAnimation];
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

- (void)beginEditName
{
    [self.textFieldName becomeFirstResponder];
}

- (void)beginEditDescription
{
    [self.textViewDescription becomeFirstResponder];
}

- (void)showFullScreenPhoto
{
    
}

- (void)closeView
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)openPhotoCamera
{
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        self.imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    } else {
        self.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    [self presentImagePicker];
}

- (void)openPhotoLibrary
{
    self.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentImagePicker];
}

- (UIImage *)imagePhoto
{
    return self.imageViewPhoto.image;
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

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    
//    [self.popOver dismissPopoverAnimated:YES];
    
    // Extracting image from the picker and saving it
    NSString *mediaType = info[UIImagePickerControllerMediaType];
    if ([mediaType isEqualToString:@"public.image"]){
        
        if ([self.presenter respondsToSelector:@selector(onDidSelectImage:)]) {
            [self.presenter onDidSelectImage:info[UIImagePickerControllerOriginalImage]];
        }
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    
//    [self.popOver dismissPopoverAnimated:YES];
}

#pragma mark = TableView

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
    
    if ([cell.reuseIdentifier isEqualToString:MTItemDetailViewMapCellIdentifier]) {
        
        if ([self.presenter respondsToSelector:@selector(onDidSelectMapCell)]) {
            [self.presenter onDidSelectMapCell];
        }
        
    } else if ([cell.reuseIdentifier isEqualToString:MTItemDetailViewNameCellIdentifier]) {
        
        if ([self.presenter respondsToSelector:@selector(onDidSelectNameCell)]) {
            [self.presenter onDidSelectNameCell];
        }
        
    } else if ([cell.reuseIdentifier isEqualToString:MTItemDetailViewDescriptionCellIdentifier]) {
        
        if ([self.presenter respondsToSelector:@selector(onDidSelectDescriptionCell)]) {
            [self.presenter onDidSelectDescriptionCell];
        }
        
    } else if ([cell.reuseIdentifier isEqualToString:MTItemDetailViewImageCellIdentifier]) {

        if ([self.presenter respondsToSelector:@selector(onDidSelectImageCell)]) {
            [self.presenter onDidSelectImageCell];
        }
        
    } 
}

#pragma mark - Helper

- (void)configureView
{
    _imagePicker = [[UIImagePickerController alloc] init];
    self.imagePicker.delegate = self;
}

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

- (void)presentImagePicker
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        //        UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:self.imagePicker];
        //        [popover presentPopoverFromRect:presentingViewController.navigationController.navigationBar.bounds
        //                                 inView:presentingViewController.view permittedArrowDirections:UIPopoverArrowDirectionAny
        //                               animated:YES];
        //        self.popOver = popover;
    } else {
        [self presentViewController:self.imagePicker
                           animated:YES
                         completion:nil];
    }
}

@end
