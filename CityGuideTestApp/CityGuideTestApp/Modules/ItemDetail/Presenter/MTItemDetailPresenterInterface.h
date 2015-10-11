//
//  MTShowPlaceDetailPresenterInterface.h
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 10.10.15.
//  Copyright © 2015 MAXIM TSVETKOV. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MTRootTablePresenterInterface.h"

@protocol MTItemDetailPresenterInterface <NSObject, MTRootTablePresenterInterface>

@optional

- (void)onDidChangeMapCoordinates:(NSDictionary *)coordinates;
- (void)onDidChangeTextFieldName:(NSString *)name;
- (void)onDidChangeTextViewDescription:(NSString *)description;
- (void)onDidSelectMapCell;
- (void)onDidSelectNameCell;
- (void)onDidSelectDescriptionCell;
- (void)onDidSelectImageCell;
- (void)onDidSelectImage:(UIImage *)image;

@end
