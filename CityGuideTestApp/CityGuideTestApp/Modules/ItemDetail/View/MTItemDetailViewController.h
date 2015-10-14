//
//  MTItemDetailViewController.h
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 10.10.15.
//  Copyright © 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTRootTableViewController.h"
#import <MapKit/MapKit.h>
#import "MTItemDetailViewInterface.h"
#import "MTItemDetailPresenterInterface.h"

@interface MTItemDetailViewController : MTRootTableViewController
<
    MTItemDetailViewInterface,
    UITextFieldDelegate,
    UITextViewDelegate,
    UIImagePickerControllerDelegate,
    UINavigationControllerDelegate
>

@property (nonatomic, strong) IBOutlet UITableViewCell *photoCell;
@property (nonatomic, strong) id<MTItemDetailPresenterInterface> presenter;
@property (nonatomic, strong) IBOutlet MKMapView *mapView;
@property (nonatomic, strong) IBOutlet UITextField *textFieldName;
@property (nonatomic, strong) IBOutlet UITextView *textViewDescription;
@property (nonatomic, strong) IBOutlet UIImageView *imageViewPhoto;

- (IBAction)saveButtonPressed:(id)sender;

@end
