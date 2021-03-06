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
#import "UIImage+MTEditing.h"

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
    
    if ([self.presenter respondsToSelector:@selector(onWillAppearView)]) {
        [self.presenter onWillAppearView];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if ([self.presenter respondsToSelector:@selector(onDidAppearView)]) {
        [self.presenter onDidAppearView];
    }
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
    
    _placeAnnotation = [[MTPlaceAnnotation alloc] initWithCoordinate:center];
    [self.mapView addAnnotation:self.placeAnnotation];
    
    [self.mapView setRegion:region animated:YES];
    [self.mapView regionThatFits:region];
    
    if ([self.presenter respondsToSelector:@selector(onDidChangeMapCoordinates:)]) {
        [self.presenter onDidChangeMapCoordinates:@{
                                                    @"latitude" : @(center.latitude),
                                                    @"longitude" : @(center.longitude)
                                                    }];
    }
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

- (void)configureImageWithImage:(UIImage *)image
{
    self.imageViewPhoto.hidden = NO;
    self.photoCell.textLabel.text = @"";
    self.photoCell.accessoryType = UITableViewCellAccessoryNone;
    
    CGFloat scaledHeight = CGRectGetWidth(self.photoCell.contentView.frame) * image.size.height / image.size.width;
    CGSize scaledSize = CGSizeMake(self.photoCell.contentView.frame.size.width, scaledHeight);
    
    image = [image mt_resizeToSize:scaledSize];
    
    CGRect cropRect = CGRectMake(0,
                                 image.size.height / 2,
                                 image.size.width,
                                 image.size.height);
    
    image = [image mt_cropToRect:cropRect];

    (self.imageViewPhoto).image = image;
}

- (void)configureRightBarButtonOnNavigationBarAsSave
{
    UIBarButtonItem *saveBarButton = [[UIBarButtonItem alloc]
                                      initWithBarButtonSystemItem:UIBarButtonSystemItemSave
                                      target:self
                                      action:@selector(saveButtonPressed:)];
    self.navigationItem.rightBarButtonItem = saveBarButton;
}

- (void)configureLeftBarButtonOnNavigationBarAsCancel
{
    UIBarButtonItem *cancelBarButton = [[UIBarButtonItem alloc]
                                      initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                      target:self
                                      action:@selector(cancelButtonPressed:)];
    self.navigationItem.leftBarButtonItem = cancelBarButton;
}

- (void)configureLeftBarButtonOnNavigationBarAsClose
{
    UIBarButtonItem *closeBarButton = [[UIBarButtonItem alloc]
                                       initWithTitle:NSLocalizedString(@"Close", nil)
                                       style:UIBarButtonItemStyleBordered
                                       target:self
                                       action:@selector(closeButtonPressed:)];
    self.navigationItem.leftBarButtonItem = closeBarButton;
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
    for (UIGestureRecognizer *gestureRecognizer in (self.mapView).gestureRecognizers) {
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

- (void)closeView
{
    if (IS_IPAD) {
        [self dismissViewControllerAnimated:YES
                                 completion:nil];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
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
    if ([self.presenter respondsToSelector:@selector(onDidChangeTextFieldName:)]) {
        [self.presenter onDidChangeTextFieldName:self.textFieldName.text];
    }
    
    if ([self.presenter respondsToSelector:@selector(onDidPressRightBarButtonOnNavigationBar)]) {
        [self.presenter onDidPressRightBarButtonOnNavigationBar];
    }
}

- (IBAction)closeButtonPressed:(id)sender
{
    [self dismissViewControllerAnimated:YES
                             completion:nil];
}

- (IBAction)cancelButtonPressed:(id)sender
{
    [self dismissViewControllerAnimated:YES
                             completion:nil];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if([string isEqualToString:@"\n"]){
        
        [self.textFieldName endEditing:YES];
        
        return NO;
    } else {
        
        if ([self.presenter respondsToSelector:@selector(onDidChangeTextFieldName:)]) {
            [self.presenter onDidChangeTextFieldName:textField.text];
        }
    }
    
    return YES;
}

#pragma mark - UITextViewDelegate

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if([text isEqualToString:@"\n"]){
        
        [self.textViewDescription endEditing:YES];
        
        return NO;
    }
    
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView
{
    if ([self.presenter respondsToSelector:@selector(onDidChangeTextViewDescription:)]) {
        [self.presenter onDidChangeTextViewDescription:textView.text];
    }
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
        
        if ((self.textViewDescription.text).length > 0) {
            return [self.textViewDescription sizeThatFits:CGSizeMake(self.textViewDescription.frame.size.width, CGFLOAT_MAX)].height;
        } else {
            return 100.0f;
        }        
        
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

        if ([self.presenter respondsToSelector:@selector(onDidSelectImageCellWithRect:)]) {
            CGRect rect = [tableView rectForRowAtIndexPath:indexPath];
            rect = [tableView convertRect:rect toView:tableView.superview];
            [self.presenter onDidSelectImageCellWithRect:rect];
        }
        
    } 
}

#pragma mark - MapView

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    MKPinAnnotationView *pinView;
    
    if ([annotation isEqual:self.placeAnnotation]) {
        pinView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:MTItemDetailViewPinAnnotationIdentifier];
        
        if (pinView == nil) {
            pinView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:MTItemDetailViewPinAnnotationIdentifier];
            pinView.animatesDrop = YES;
        }
    }
    
    return pinView;
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
    
    /*
    TODO: 
     Use CLGeocoder to fetch placemark information about dropped point.
     It can be also Wikipedia/Google Api instead of CLGeocoder    
     */
    
    CGPoint touchPoint = [gestureRecognizer locationInView:self.mapView];
    CLLocationCoordinate2D touchMapCoordinate =
    [self.mapView convertPoint:touchPoint toCoordinateFromView:self.mapView];
    
    if (self.placeAnnotation) {
        [self.mapView removeAnnotation:self.placeAnnotation];
        _placeAnnotation = nil;
    }
    _placeAnnotation = [[MTPlaceAnnotation alloc] initWithCoordinate:touchMapCoordinate];
    [self.mapView addAnnotation:self.placeAnnotation];
    
    if ([self.presenter respondsToSelector:@selector(onDidChangeMapCoordinates:)]) {
        [self.presenter onDidChangeMapCoordinates:@{
                                                    @"latitude" : @(touchMapCoordinate.latitude),
                                                    @"longitude" : @(touchMapCoordinate.longitude)
                                                    }];
    }
}

- (void)presentImagePicker
{
    if (IS_IPAD) {
        UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:self.imagePicker];
        [popover presentPopoverFromRect:self.view.frame
                                 inView:self.view
               permittedArrowDirections:UIPopoverArrowDirectionAny
                               animated:YES];
    } else {
        [self presentViewController:self.imagePicker
                           animated:YES
                         completion:nil];
    }
}

@end
