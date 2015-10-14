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
#import "MTImageManager.h"
#import "NSString+MTFormatting.h"

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
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.presenter onWillAppearView];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.presenter onDidAppearView];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];

    if ([self.presenter respondsToSelector:@selector(onWillDisappearView)]) {
        [self.presenter onWillDisappearView];
    }
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

- (void)reloadCells
{
    [self.tableView beginUpdates];
    [self.tableView endUpdates];
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

- (void)configurePhotoCellAsAddImage
{
    self.imageViewPhoto.hidden = YES;
    
    self.photoCell.textLabel.text = NSLocalizedString(@"Add Image", nil);
    self.photoCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
}

- (void)configurePhotoCellAsNoImage
{
    self.imageViewPhoto.hidden = YES;
    
    self.photoCell.textLabel.text = NSLocalizedString(@"No Image", nil);
    self.photoCell.accessoryType = UITableViewCellAccessoryNone;
}

- (void)configureImageWithFileName:(NSString *)fileName
{
    self.imageViewPhoto.hidden = NO;
    self.photoCell.textLabel.text = @"";
    self.photoCell.accessoryType = UITableViewCellAccessoryNone;
    
    NSString *filePath = [fileName mt_formatDocumentsPath];
    UIImage *image = [UIImage imageWithContentsOfFile:filePath];
    NSLog(@"bounds %f %f", self.photoCell.bounds.size.width, self.photoCell.contentView.bounds.size.height);
    CGFloat scaledHeight = CGRectGetWidth(self.photoCell.contentView.frame) * image.size.height / image.size.width;
    CGSize scaledSize = CGSizeMake(self.photoCell.contentView.frame.size.width, scaledHeight);
    
    image = [[MTImageManager sharedManager] imageWithImage:image
                                              scaledToSize:scaledSize];
    
    CGRect cropRect = CGRectMake(0,
                                 image.size.height / 2,
                                 image.size.width,
                                 image.size.height);
    
    image = [[MTImageManager sharedManager] imageWithImage:image
                                                  cropRect:cropRect];

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

- (void)enableRightBarButtonOnNavigationBar
{
    self.navigationItem.rightBarButtonItem.enabled = YES;
}

- (void)disableRightBarButtonOnNavigationBar
{
    self.navigationItem.rightBarButtonItem.enabled = NO;
}

- (void)enableActivityForImageLoading
{
    [self.imageViewPhoto mt_startActivityAnimation];
}

- (void)disableActivityForImageLoading
{
    [self.imageViewPhoto mt_stopActivityAnimation];
}

- (void)enableTextField
{
    self.textFieldName.userInteractionEnabled = YES;
}

- (void)disableTextField
{
    self.textFieldName.userInteractionEnabled = NO;
}

- (void)enableTextView
{
    self.textViewDescription.userInteractionEnabled = YES;
}

- (void)disableTextView
{
    self.textViewDescription.userInteractionEnabled = NO;
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

#pragma mark - IB Actions

- (IBAction)saveButtonPressed:(id)sender
{
    NSLog(@"save button pressed");
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
    
    if ([cell.reuseIdentifier isEqualToString:MTItemDetailViewDescriptionCellIdentifier]) {
        
        return [self.textViewDescription sizeThatFits:CGSizeMake(self.textViewDescription.frame.size.width, CGFLOAT_MAX)].height;
        
    } else {
        return [super tableView:tableView heightForRowAtIndexPath:indexPath];
    }
}

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
