//
//  MTItemDetailWireframe.m
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 07.10.15.
//  Copyright (c) 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTItemDetailWireframe.h"
#import "MTItemDetailViewController.h"
#import "MTShowPlaceDetailPresenter.h"
#import "MTPlaceDetailMapViewHelper.h"
#import "MTPlaceDetailFetcher.h"

@interface MTItemDetailWireframe ()

@property (nonatomic, weak) MTItemDetailViewController *viewController;

@end

@implementation MTItemDetailWireframe

#pragma mark - MTCityListModuleInterface

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

#pragma mark - Helper

- (void)configureShowDetailStackWithItem:(id)item
{
    //init interactor
    MTPlaceDetailFetcher *placeDetailFetcher = [[MTPlaceDetailFetcher alloc] initWithPlace:item];

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

@end
