//
//  MTItemListWireframe.m
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 07.10.15.
//  Copyright (c) 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTItemListWireframe.h"
#import "MTItemDetailModuleInterface.h"
#import "MTItemWebService.h"
#import "MTFetchedResultsControllerBasedItemListCache.h"
#import "MTArrayBasedItemListCache.h"
#import "MTItemDataManager.h"
#import "MTItemListRequester.h"
#import "MTItemListExpander.h"
#import "MTItemListSearcher.h"
#import "MTItemListTablePresenter.h"
#import "MTItemListPresenter.h"
#import "MTItemListTableViewController.h"
#import "MTItemListViewController.h"

@interface MTItemListWireframe ()

@property (nonatomic, strong) MTItemListViewController *viewController;

@end

@implementation MTItemListWireframe

#pragma mark - MTItemListModuleInterface

- (void)showItemListViewInWindow:(UIWindow *)window
{
    //init
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Base" bundle: nil];
    _viewController = [storyboard instantiateViewControllerWithIdentifier:@"ItemListViewController"];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:self.viewController];
    
    //configure
    [self configureStack];
    
    //navigate
    window.rootViewController = navigationController;
}

#pragma mark - Public

- (void)onDidAddNewItem
{
    [self.itemDetailModule addNewPlaceWithNavigationController:self.viewController.navigationController];
}

- (void)onDidSelectItem:(id)item
{
    [self.itemDetailModule showDetailsForPlace:item
                          navigationController:self.viewController.navigationController];
}

#pragma mark - Helper

- (void)configureStack
{
    //init web serice
    MTItemWebService *itemWebService = [[MTItemWebService alloc] init];
    
    //init cache
    MTArrayBasedItemListCache *cityListCache = [[MTArrayBasedItemListCache alloc] init];
    MTFetchedResultsControllerBasedItemListCache *placeListCache = [[MTFetchedResultsControllerBasedItemListCache alloc] init];
    
    //init data manager
    MTItemDataManager *itemDataManager = [[MTItemDataManager alloc] init];
    
    //init interactor
    MTItemListRequester *itemListRequester = [[MTItemListRequester alloc]
                                              initWithCityListCache:cityListCache
                                              placeListCache:placeListCache
                                              itemDataManager:itemDataManager];
    MTItemListExpander *itemListExpander = [[MTItemListExpander alloc]
                                            initWithCityListCache:cityListCache
                                            placeListCache:placeListCache
                                            itemDataManager:itemDataManager];
    
    //init presenter
    MTItemListTablePresenter *itemListTablePresenter = [[MTItemListTablePresenter alloc]
                                                        initWithItemListRequester:itemListRequester
                                                        itemListExpander:itemListExpander
                                                        wireframe:self];
    MTItemListPresenter *itemListPresenter = [[MTItemListPresenter alloc] initWithItemListRequester:itemListRequester
                                                                                          wireframe:self];
    
    //init view controller
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Base" bundle: nil];
    MTItemListTableViewController *itemListTableViewController = [storyboard instantiateViewControllerWithIdentifier:@"ItemListTableViewController"];
    itemListTableViewController.enableIndexedList = NO;
    itemListTableViewController.enablePullToRefresh = NO;
    
    //bind view controller
    self.viewController.childTableViewController = itemListTableViewController;
    self.viewController.presenter = itemListPresenter;
    itemListTableViewController.presenter = itemListTablePresenter;
    
    //bind presenter
    itemListPresenter.userInterface = self.viewController;
    itemListTablePresenter.userInterface = itemListTableViewController;
    
    //bind interactor
    itemListRequester.outputs = @[itemListTablePresenter];
    itemListExpander.outputs = @[itemListTablePresenter];
    
    //bind data manager
    itemDataManager.itemWebService = itemWebService;
}

@end
