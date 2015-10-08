//
//  MTItemListViewInterface.h
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 07.10.15.
//  Copyright (c) 2015 MAXIM TSVETKOV. All rights reserved.
//

@protocol MTItemListViewInterface <NSObject>

- (void)configureNavigationBarWithTitle: (NSString *)title;

@optional
- (void)configureLeftBarButtonWithTitle: (NSString *)title;
- (void)configureRightBarButtonWithTitle: (NSString *)title;
- (void)configureSearchBarWithPlaceholder: (NSString *)placeholder;

@end
