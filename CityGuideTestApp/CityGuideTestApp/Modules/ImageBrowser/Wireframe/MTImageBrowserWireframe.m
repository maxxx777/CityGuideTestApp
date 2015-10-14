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

- (void)showImageWithFileName:(NSString *)fileName
         navigationController:(UINavigationController *)navigationController
{
    //init
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Base" bundle: nil];
    _viewController = [storyboard instantiateViewControllerWithIdentifier:@"ImageBrowserViewController"];
    
    //configure
    [self configureStackWithImageFileName:fileName];
    
    //navigate
    [navigationController pushViewController:self.viewController
                                    animated:YES];
}

#pragma mark - Helper

- (void)configureStackWithImageFileName:(NSString *)fileName
{
    //init presenter
    MTImageBrowserPresenter *presenter = [[MTImageBrowserPresenter alloc]
                                          initWithImageFileName:fileName
                                          wireframe:self];

    //bind view controller - presenter
    self.viewController.presenter = presenter;
    
    //bind presenter - view controller
    presenter.userInterface = self.viewController;
}

@end
