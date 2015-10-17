//
//  MTItemDetailViewInterface.h
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 10.10.15.
//  Copyright © 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTRootViewInterface.h"

@protocol MTItemDetailViewInterface <NSObject, MTRootViewInterface>

- (void)configureMapWithCoordinates:(NSDictionary * _Nonnull)coordinates;
- (void)configureNameWithText:(NSString * _Nonnull)text;
- (void)configureDescriptionWithText:(NSString * _Nonnull)text;
- (void)reloadCells;
- (void)configurePhotoCellAsAddImage;
- (void)configurePhotoCellAsNoImage;
- (void)configureImageWithImage:(UIImage * _Nonnull)image;

- (void)configureRightBarButtonOnNavigationBarAsSave;
- (void)configureLeftBarButtonOnNavigationBarAsCancel;
- (void)configureLeftBarButtonOnNavigationBarAsClose;

- (void)enableRightBarButtonOnNavigationBar;
- (void)disableRightBarButtonOnNavigationBar;

- (void)beginEditName;
- (void)beginEditDescription;

- (void)enableActivityForImageLoading;
- (void)disableActivityForImageLoading;

- (void)enableTextField;
- (void)disableTextField;

- (void)enableTextView;
- (void)disableTextView;

- (void)enableDropPinOnMapView;
- (void)disableDropPinOnMapView;

- (void)openPhotoCamera;
- (void)openPhotoLibrary;

- (void)closeView;

@end
