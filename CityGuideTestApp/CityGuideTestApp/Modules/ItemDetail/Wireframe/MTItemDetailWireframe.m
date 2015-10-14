//
//  MTItemDetailWireframe.m
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 07.10.15.
//  Copyright (c) 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTItemDetailWireframe.h"
#import "MTImageBrowserModuleInterface.h"
#import "MTItemDetailViewController.h"
#import "MTShowPlaceDetailPresenter.h"
#import "MTEditPlaceDetailPresenter.h"
#import "MTPlaceDetailMapViewHelper.h"
#import "MTPlaceDetailFetcher.h"
#import "MTPlaceDetailConfigurator.h"
#import "MTItemOperator.h"
#import "MTItemDataManager.h"

@interface MTItemDetailWireframe ()

@property (nonatomic, weak) MTItemDetailViewController *viewController;

@end

@implementation MTItemDetailWireframe

#pragma mark - MTItemDetailModuleInterface

- (void)showDetailsForPlace:(id)place
       navigationController:(UINavigationController *)navigationController
{
    //init
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Base" bundle: nil];
    _viewController = [storyboard instantiateViewControllerWithIdentifier:@"ItemDetailViewController"];
    
    //configure
    [self configureShowDetailStackWithItem:place];
    
    //navigate
    [navigationController pushViewController:self.viewController
                                    animated:YES];
}

- (void)addNewPlaceWithNavigationController:(UINavigationController *)navigationController
{
    //init
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Base" bundle: nil];
    _viewController = [storyboard instantiateViewControllerWithIdentifier:@"ItemDetailViewController"];
    
    //configure
    [self configureEditDetailStack];
    
    //navigate
    [navigationController pushViewController:self.viewController
                                    animated:YES];
}

#pragma mark - Public

- (void)onDidSelectImage:(UIImage *)image
{
    [self.imageBrowserModule showImage:image
                  navigationController:self.viewController.navigationController];
}

#pragma mark - Helper

- (void)configureShowDetailStackWithItem:(id)item
{
    //init data manager
    MTItemDataManager *itemDataManager = [[MTItemDataManager alloc] init];
    
    //init interactor
    MTPlaceDetailFetcher *placeDetailFetcher = [[MTPlaceDetailFetcher alloc]
                                                initWithPlace:item                                                
                                                itemDataManager:itemDataManager];

    //init presenter
    MTShowPlaceDetailPresenter *presenter = [[MTShowPlaceDetailPresenter alloc]
                                             initWithPlaceDetailFetcher:placeDetailFetcher
                                             wireframe:self];
    
    //init helper
    MTPlaceDetailMapViewHelper *mapViewHelper = [[MTPlaceDetailMapViewHelper alloc] initWithPlace:item];
    
    //bind view controller - presenter
    self.viewController.presenter = presenter;
    
    //bind view controller - helper
    self.viewController.mapViewHelper = mapViewHelper;
    
    //bind presenter - view controller
    presenter.userInterface = self.viewController;
    
    //bind presenter - interactor
    placeDetailFetcher.outputs = @[presenter];
}

- (void)configureEditDetailStack
{
    //init data manager
    MTItemDataManager *itemDataManager = [[MTItemDataManager alloc] init];
    
    //init interactor
    MTPlaceDetailConfigurator *placeDetailConfigurator = [[MTPlaceDetailConfigurator alloc] initWithNewItem];
    MTItemOperator *itemOperator = [[MTItemOperator alloc] initWithItemListCache:nil
                                                                 itemDataManager:itemDataManager];
    
    //init presenter
    MTEditPlaceDetailPresenter *presenter = [[MTEditPlaceDetailPresenter alloc]
                                             initWithPlaceDetailConfigurator:placeDetailConfigurator
                                             itemOperator:itemOperator
                                             wireframe:self];
    
    //bind view controller - presenter
    self.viewController.presenter = presenter;
    
    //bind presenter - view controller
    presenter.userInterface = self.viewController;
    
    //bind presenter - interactor
    placeDetailConfigurator.outputs = @[presenter];
    itemOperator.outputs = @[presenter];
}

@end
