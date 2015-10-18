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

- (void)onWillRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
                                  duration:(NSTimeInterval)duration;
- (void)onDidRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation;

- (void)onDidPressLeftBarButtonOnNavigationBar;
- (void)onDidPressRightBarButtonOnNavigationBar;
- (void)onDidPressLeftBarButtonOnToolbar:(UIBarButtonItem * _Nonnull)barButton;
- (void)onDidPressRightBarButtonOnToolbar:(UIBarButtonItem * _Nonnull)barButton;

@end
