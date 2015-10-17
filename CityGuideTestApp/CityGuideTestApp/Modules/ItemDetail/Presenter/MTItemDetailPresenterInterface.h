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

- (void)onDidChangeMapCoordinates:(NSDictionary *)coordinates;
- (void)onDidChangeTextFieldName:(NSString *)name;
- (void)onDidChangeTextViewDescription:(NSString *)description;
- (void)onDidSelectMapCell;
- (void)onDidSelectNameCell;
- (void)onDidSelectDescriptionCell;
- (void)onDidSelectImageCellWithRect:(CGRect)rect;
- (void)onDidSelectImage:(UIImage *)image;

@end
