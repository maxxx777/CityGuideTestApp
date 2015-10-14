//
//  MTItemListModuleInterface.h
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 07.10.15.
//  Copyright (c) 2015 MAXIM TSVETKOV. All rights reserved.
//

@protocol MTItemDetailModuleInterface <NSObject>

- (void)showDetailsForPlace:(id _Nonnull)place
       navigationController:(UINavigationController * _Nonnull)navigationController;
- (void)addNewPlaceWithNavigationController:(UINavigationController * _Nonnull)navigationController;

@end
