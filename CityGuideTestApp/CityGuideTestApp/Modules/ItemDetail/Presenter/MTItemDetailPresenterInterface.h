//
//  MTShowPlaceDetailPresenterInterface.h
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 10.10.15.
//  Copyright © 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTRootCollectionPresenterInterface.h"

@protocol MTItemDetailPresenterInterface <NSObject, MTRootCollectionPresenterInterface>

@optional

- (void)onDidChangeMapCoordinates:(NSDictionary * _Nonnull)coordinates;
- (void)onDidChangeTextFieldName:(NSString * _Nonnull)name;
- (void)onDidChangeTextViewDescription:(NSString * _Nonnull)description;
- (void)onDidSelectMapCell;
- (void)onDidSelectNameCell;
- (void)onDidSelectDescriptionCell;
- (void)onDidSelectImageCellWithRect:(CGRect)rect;
- (void)onDidSelectImage:(UIImage * _Nonnull)image;

@end
