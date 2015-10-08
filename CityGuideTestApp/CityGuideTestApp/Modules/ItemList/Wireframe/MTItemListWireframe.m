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
#import "MTItemListFetcher.h"
#import "MTItemListSearcher.h"
#import "MTItemListSearchPresenter.h"
#import "MTItemListTablePresenter.h"
#import "MTItemListPresenter.h"
#import "MTItemListSearchViewController.h"
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
    _viewController = [storyboard instantiateViewControllerWithIdentifier:@"ItemListViewControllerWithSearch"];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:self.viewController];
    
    //configure
    [self configureStack];
    
    //navigate
    window.rootViewController = navigationController;
}

#pragma mark - Public

- (void)onDidSelectItem:(id)item
{
    [self.itemDetailModule showItemDetailsForItem:item
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
    MTItemListFetcher *cityListFetcher = [[MTItemListFetcher alloc]
                                          initWithItemListCache:cityListCache
                                          rootDataManager:itemDataManager];
    MTItemListFetcher *placeListFetcher = [[MTItemListFetcher alloc]
                                          initWithItemListCache:placeListCache
                                          rootDataManager:itemDataManager];
    
    //init presenter
    MTItemListTablePresenter *itemListTablePresenter = [[MTItemListTablePresenter alloc]
                                                        initWithItemListRequester:itemListRequester
                                                        cityListFetcher:cityListFetcher
                                                        placeListFetcher:placeListFetcher
                                                        wireframe:self];
    MTItemListPresenter *itemListPresenter = [[MTItemListPresenter alloc] initWithWireframe:self];
    
    //init view controller
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Base" bundle: nil];
    MTItemListTableViewController *itemListTableViewController = [storyboard instantiateViewControllerWithIdentifier:@"ItemListTableViewController"];
    itemListTableViewController.enableIndexedList = YES;
    itemListTableViewController.enablePullToRefresh = YES;
    
    //bind view controller
    self.viewController.childTableViewController = itemListTableViewController;
    self.viewController.presenter = itemListPresenter;
    itemListTableViewController.presenter = itemListTablePresenter;
    
    //bind presenter
    itemListPresenter.userInterface = self.viewController;
    itemListTablePresenter.userInterface = itemListTableViewController;
    
    //bind interactor
    itemListRequester.outputs = @[itemListTablePresenter];
    cityListFetcher.outputs = @[itemListTablePresenter];
    placeListFetcher.outputs = @[itemListTablePresenter];
    
    //bind data manager
    itemDataManager.itemWebService = itemWebService;
}

@end
