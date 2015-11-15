//
//  MTAppRouterInterface.h
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 14.11.15.
//  Copyright © 2015 MAXIM TSVETKOV. All rights reserved.
//

@protocol MTEditPlaceDetailDelegate;

@protocol MTAppRouterInterface <NSObject>

- (void)showRootViewControllerInWindow:(UIWindow *)window;
- (void)showDetailsForPlace:(id)place
                   fromRect:(CGRect)rect
         fromViewController:(UIViewController *)fromViewController;
- (void)showImage:(UIImage * _Nonnull)image navigationController:(UINavigationController * _Nonnull)navigationController;
- (void)addNewPlaceWithNavigationController:(UINavigationController *)navigationController
                                   delegate:(id<MTEditPlaceDetailDelegate>)delegate;

@end
