//
//  MTItemDetailViewInterface.h
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 10.10.15.
//  Copyright © 2015 MAXIM TSVETKOV. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MTItemDetailViewInterface <NSObject>

- (void)configureNavigationBarWithTitle: (NSString *)title;
- (void)configureMapWithCoordinates:(NSDictionary *)coordinates;
- (void)configureNameWithText:(NSString *)text;
- (void)configureDescriptionWithText:(NSString *)text;
- (void)configureImageWithURL:(NSURL *)url;

- (void)enableDropPinOnMapView;
- (void)disableDropPinOnMapView;

- (void)closeView;

@end
