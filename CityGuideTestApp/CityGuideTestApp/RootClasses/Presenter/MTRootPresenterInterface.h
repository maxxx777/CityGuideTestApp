//
//  MTRootPresenterInterface.h
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 07.10.15.
//  Copyright (c) 2015 MAXIM TSVETKOV. All rights reserved.
//

@protocol MTRootPresenterInterface <NSObject>

@optional

- (void)onDidLoadView;
- (void)onWillCloseView;

- (void)onWillAppearView;
- (void)onDidAppearView;
- (void)onWillDisappearView;
- (void)onDidDisappearView;

- (void)onDidPressLeftBarButtonOnNavigationBar;
- (void)onDidPressRightBarButtonOnNavigationBar;
- (void)onDidPressLeftBarButtonOnToolbar;
- (void)onDidPressRightBarButtonOnToolbar;

@end
