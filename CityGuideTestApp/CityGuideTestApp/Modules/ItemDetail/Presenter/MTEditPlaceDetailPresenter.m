//
//  MTShowPlaceDetailPresenter.m
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 10.10.15.
//  Copyright © 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTEditPlaceDetailPresenter.h"
#import "MTItemDetailWireframe.h"
#import "MTItemDetailViewInterface.h"
#import "MTLocationManager.h"
#import "MTImageManager.h"
#import "MTAlertWrapper.h"
#import "MTFileManager.h"

@interface MTEditPlaceDetailPresenter ()
{
    MTFileManager *fileManager;
    BOOL isSaved;
}

@property (nonatomic, strong) id<MTPlaceDetailConfiguratorInputInterface>placeDetailConfigurator;
@property (nonatomic, strong) id<MTItemOperatorInputInterface>itemOperator;
@property (nonatomic, weak) MTItemDetailWireframe *wireframe;
@property (nonatomic) BOOL isFirstAppearance;

@end

@implementation MTEditPlaceDetailPresenter

- (instancetype)initWithPlaceDetailConfigurator:(id<MTPlaceDetailConfiguratorInputInterface>)placeDetailConfigurator
                                   itemOperator:(id<MTItemOperatorInputInterface>)itemOperator
                                      wireframe:(MTItemDetailWireframe *)wireframe
{
    self = [super init];
    if (self) {
        
        _placeDetailConfigurator = placeDetailConfigurator;
        _itemOperator = itemOperator;
        _wireframe = wireframe;
        
        _isFirstAppearance = YES;
        fileManager = [[MTFileManager alloc] init];
        isSaved = NO;
    }
    return self;
}

#pragma mark - MTItemDetailPresenterInterface

- (void)onWillAppearView
{
    [self.userInterface enableRightBarButtonOnNavigationBar];
    
    if (self.isFirstAppearance) {
        
        [self.userInterface configureNavigationBarWithTitle:NSLocalizedString(@"New Place", nil)];
        
        if (IS_IPAD) {
            [self.userInterface configureLeftBarButtonOnNavigationBarAsCancel];
        }
        [self.userInterface configureRightBarButtonOnNavigationBarAsSave];
        
        [self.userInterface configurePhotoCellAsAddImage];        
    }
}

- (void)onDidAppearView
{
    if (self.isFirstAppearance) {
        
        if ([[MTLocationManager sharedManager] currentLocation]) {
            [self.userInterface configureMapWithCoordinates:[[MTLocationManager sharedManager] currentLocation]];
        }
        
        [self.userInterface enableDropPinOnMapView];
        
        self.isFirstAppearance = NO;
    }
}

- (void)onWillDisappearView
{
    [self.userInterface disableRightBarButtonOnNavigationBar];
}

- (void)onWillCloseView
{
    if (!isSaved) {
        if ([self.placeDetailConfigurator fileName]) {
            [fileManager removeFileWithName:[self.placeDetailConfigurator fileName]
                                 completion:nil];
        }
    }
}

- (void)onDidChangeMapCoordinates:(NSDictionary *)coordinates
{
    [self.placeDetailConfigurator configurePlaceCoordinates:coordinates];
}

- (void)onDidChangeTextFieldName:(NSString *)name
{
    [self.placeDetailConfigurator configurePlaceName:name];
}

- (void)onDidChangeTextViewDescription:(NSString *)description
{
    [self.placeDetailConfigurator configurePlaceDescription:description];
}

- (void)onDidPressRightBarButtonOnNavigationBar
{
    if (![self.placeDetailConfigurator placeCoordinates]) {
        MTAlertWrapper *alertWrapper = [[MTAlertWrapper alloc] init];
        [alertWrapper showAlertInViewController:self.userInterface
                                      withTitle:NSLocalizedString(@"Place Coordinates", nil)
                                        message:NSLocalizedString(@"Please Drop Pin on Map where Place is Located", nil)];
    } else if (![self.placeDetailConfigurator placeName] || [[self.placeDetailConfigurator placeName] length] == 0) {
        MTAlertWrapper *alertWrapper = [[MTAlertWrapper alloc] init];
        [alertWrapper showAlertInViewController:self.userInterface
                                      withTitle:NSLocalizedString(@"Place Name", nil)
                                        message:NSLocalizedString(@"Please Input Place Name", nil)];
    } else {
        
        /*
        TODO:
         Save new place with selected city (new place has Unknown City now). 
         City can be detected by either CLGeocoder or Wikipedia/Google Api. 
         Also it can be added manually.
         */
        
        [self.itemOperator saveItem:[self.placeDetailConfigurator currentItem]];
    }
}

- (void)onDidSelectNameCell
{
    [self.userInterface beginEditName];
}

- (void)onDidSelectDescriptionCell
{
    [self.userInterface beginEditDescription];
}

- (void)onDidSelectImageCellWithRect:(CGRect)rect
{
    MTAlertWrapper *alertWrapper = [[MTAlertWrapper alloc] init];
    [alertWrapper showActionSheetInViewController:self.userInterface
                                    fromBarButton:nil
                                         fromRect:rect
                                        withTitle:NSLocalizedString(@"Attach photo", nil)
                                cancelButtonTitle:NSLocalizedString(@"Cancel", nil)
                           otherButtonTitlesArray:@[NSLocalizedString(@"Camera", nil), NSLocalizedString(@"Photo library", nil)]
                                clickedCompletion:nil
                             didDismissCompletion:^(NSInteger buttonIndex, NSString *actionTitle, NSString *inputText){
                                 if (actionTitle) {
                                     
                                     if ([actionTitle isEqualToString:NSLocalizedString(@"Camera", nil)]) {
                                         
                                         [self.userInterface openPhotoCamera];
                                         
                                     } else if ([actionTitle isEqualToString:NSLocalizedString(@"Photo library", nil)]) {
                                         
                                         [self.userInterface openPhotoLibrary];
                                         
                                     }
                                     
                                 } else {
                                     
                                     if (buttonIndex == 1) {
                                         
                                         [self.userInterface openPhotoCamera];
                                         
                                     } else if (buttonIndex == 2) {
                                         
                                         [self.userInterface openPhotoLibrary];
                                         
                                     }
                                 }
                             }];
}

- (void)onDidSelectImage:(UIImage *)image
{
    NSData *data = UIImageJPEGRepresentation(image, 0.9f);
    if ([self.placeDetailConfigurator fileName]) {
        [fileManager removeFileWithName:[self.placeDetailConfigurator fileName]
                             completion:nil];
    }
    [fileManager saveFileWithData:data
                       completion:^(NSError *error, NSString *fileName){
                                              if (fileName) {
                                                  [self.placeDetailConfigurator configurePlaceFileName:fileName];
                                                  [self.userInterface configureImageWithImage:image];
                                              }
    }];
}

#pragma mark - MTItemOperatorOutputInterface

- (void)onDidSaveItem
{
    isSaved = YES;
    [self.userInterface closeView];
}

@end
