//
//  MTAppRouter.m
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 14.11.15.
//  Copyright © 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTAppRouter.h"
#import "MTItemListAssemblyInterface.h"
#import "MTShowPlaceDetailAssemblyInterface.h"
#import "MTImageBrowserAssemblyInterface.h"
#import "MTAddNewPlaceAssemblyInterface.h"

@implementation MTAppRouter

- (void)showRootViewControllerInWindow:(UIWindow *)window
{
    UIViewController *viewController = [self.itemListAssembly viewControllerWithAppRouter:self];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
    
    window.rootViewController = navigationController;
}

- (void)showDetailsForPlace:(id)place
                   fromRect:(CGRect)rect
         fromViewController:(UIViewController *)fromViewController
{
    UIViewController *viewController = [self.showPlaceDetailAssembly viewControllerWithAppRouter:self
                                                                                            item:place];
    if (IS_IPAD) {
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
        UIPopoverController *popoverController = [[UIPopoverController alloc] initWithContentViewController:navigationController];
        [popoverController presentPopoverFromRect:rect
                                           inView:viewController.view
                         permittedArrowDirections:UIPopoverArrowDirectionAny
                                         animated:YES];
    } else {
        [fromViewController.navigationController pushViewController:viewController
                                                           animated:YES];
    }
}

- (void)showImage:(UIImage *)image navigationController:(UINavigationController *)navigationController
{
    UIViewController *viewController = [self.imageBrowserAssembly viewControllerWithAppRouter:self
                                                                                        image:image];
    [navigationController pushViewController:viewController
                                    animated:YES];
}

- (void)addNewPlaceWithNavigationController:(UINavigationController *)navigationController
                                   delegate:(id<MTEditPlaceDetailDelegate>)delegate
{
    UIViewController *viewController = [self.addNewPlaceAssembly viewControllerWithAppRouter:self
                                                                                    delegate:delegate];
    
    if (IS_IPAD) {
        UINavigationController *navigationControllerForViewController = [[UINavigationController alloc] initWithRootViewController:viewController];
        UIPopoverController *popoverController = [[UIPopoverController alloc] initWithContentViewController:navigationControllerForViewController];
        [popoverController presentPopoverFromBarButtonItem:navigationController.topViewController.navigationItem.rightBarButtonItem
                                  permittedArrowDirections:UIPopoverArrowDirectionAny
                                                  animated:YES];
    } else {
        [navigationController pushViewController:viewController
                                        animated:YES];
    }
}

@end
