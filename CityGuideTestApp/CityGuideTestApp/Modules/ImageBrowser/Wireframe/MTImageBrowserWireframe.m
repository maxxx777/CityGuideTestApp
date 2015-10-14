//
//  MTImageBrowserWireframe.m
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 12.10.15.
//  Copyright © 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTImageBrowserWireframe.h"
#import "MTImageBrowserViewController.h"
#import "MTImageBrowserPresenter.h"

@interface MTImageBrowserWireframe ()

@property (nonatomic, weak) MTImageBrowserViewController *viewController;

@end

@implementation MTImageBrowserWireframe

#pragma mark - MTImageBrowserModuleInterface

- (void)showImage:(UIImage *)image navigationController:(UINavigationController *)navigationController
{
    //init
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Base" bundle: nil];
    _viewController = [storyboard instantiateViewControllerWithIdentifier:@"ImageBrowserViewController"];
    
    //configure
    [self configureStackWithImage:image];
    
    //navigate
    [navigationController pushViewController:self.viewController
                                    animated:YES];
}

#pragma mark - Helper

- (void)configureStackWithImage:(UIImage *)image
{
    //init presenter
    MTImageBrowserPresenter *presenter = [[MTImageBrowserPresenter alloc]
                                          initWithImage:image
                                          wireframe:self];

    //bind view controller - presenter
    self.viewController.presenter = presenter;
    
    //bind presenter - view controller
    presenter.userInterface = self.viewController;
}

@end
