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

@interface MTEditPlaceDetailPresenter ()

@property (nonatomic, strong) id<MTPlaceDetailConfiguratorInputInterface>placeDetailConfigurator;
@property (nonatomic, strong) id<MTItemOperatorInputInterface>itemOperator;
@property (nonatomic, weak) MTItemDetailWireframe *wireframe;

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
        
    }
    return self;
}

#pragma mark - MTItemDetailPresenterInterface

- (void)onDidLoadView
{
    [self.userInterface configureNavigationBarWithTitle:NSLocalizedString(@"New Place", nil)];
    
    [self.userInterface configureRightBarButtonOnNavigationBarAsSave];
    
    [self.userInterface enableDropPinOnMapView];
    
    [self.userInterface configureImageWithPlaceholder];
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
    [self.itemOperator saveItem:[self.placeDetailConfigurator currentItem]];
}

- (void)onDidSelectNameCell
{
    [self.userInterface beginEditName];
}

- (void)onDidSelectDescriptionCell
{
    [self.userInterface beginEditDescription];
}

- (void)onDidSelectImageCell
{
    MTAlertWrapper *alertWrapper = [[MTAlertWrapper alloc] init];
    [alertWrapper showActionSheetInViewController:self.userInterface
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
//    MTImageManager *imageManager = [[MTImageManager alloc] init];
//    [imageManager saveImageToFile:image
//                       completion:^(NSError *error, UIImage *image, NSString *filePath){
//                        [self.placeDetailConfigurator configurePlacePhotoPath:filePath];
//                        [self.userInterface configureImageWithFilePath:filePath];
//    }];
}

#pragma mark - MTItemOperatorOutputInterface

- (void)onDidSaveItem
{
    [self.userInterface closeView];
}

@end
