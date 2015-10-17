//
//  MTItemListModuleInterface.h
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 07.10.15.
//  Copyright (c) 2015 MAXIM TSVETKOV. All rights reserved.
//

@protocol MTEditPlaceDetailDelegate;

@protocol MTItemDetailModuleInterface <NSObject>

- (void)showDetailsForPlace:(id _Nonnull)place
                   fromRect:(CGRect)rect
             viewController:(UIViewController * _Nonnull)viewController;
- (void)addNewPlaceWithNavigationController:(UINavigationController * _Nonnull)navigationController
                                   delegate:(id<MTEditPlaceDetailDelegate>)delegate;

@end
