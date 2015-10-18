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
#import "MTItemListCollectionPresenter.h"
#import "MTItemListPresenter.h"
#import "MTItemListTableViewController.h"
#import "MTItemListCollectionViewController.h"
#import "MTItemListViewController.h"

@interface MTItemListWireframe ()

@property (nonatomic, weak) MTItemListViewController *viewController;

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

- (void)onDidAddNewItemWithDelegate:(id<MTEditPlaceDetailDelegate>)delegate
{
    [self.itemDetailModule addNewPlaceWithNavigationController:self.viewController.navigationController
                                                      delegate:delegate];
}

- (void)onDidSelectItem:(id)item
               fromRect:(CGRect)rect
{
    [self.itemDetailModule showDetailsForPlace:item
                                      fromRect:rect
                                viewController:self.viewController];
}

#pragma mark - Helper

- (void)configureStack
{
    //init web serice
    MTItemWebService *itemWebService = [[MTItemWebService alloc] init];
    
    //init data manager
    MTItemDataManager *itemDataManager = [[MTItemDataManager alloc] init];
    
    //init cache
    MTArrayBasedItemListCache *cityListCache = [[MTArrayBasedItemListCache alloc] init];
    MTFetchedResultsControllerBasedItemListCache *placeListCache = [[MTFetchedResultsControllerBasedItemListCache alloc] initWithDelegate:itemDataManager];
    
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
    MTItemListCollectionPresenter *itemListCollectionPresenter = [[MTItemListCollectionPresenter alloc]
                                                        initWithItemListRequester:itemListRequester
                                                        itemListExpander:itemListExpander
                                                        wireframe:self];
    MTItemListPresenter *itemListPresenter = [[MTItemListPresenter alloc] initWithItemListRequester:itemListRequester
                                                                                          wireframe:self];
    
    //bind view controller
    self.viewController.presenter = itemListPresenter;
    
    //bind presenter
    itemListPresenter.userInterface = self.viewController;
    
    //bind interactor
    itemListRequester.outputs = @[itemListCollectionPresenter];
    itemListExpander.outputs = @[itemListCollectionPresenter];
    
    //bind data manager
    itemDataManager.itemWebService = itemWebService;
    
    //init child view controller
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Base" bundle: nil];
    if (IS_IPAD) {
        
        MTItemListCollectionViewController *childViewController = [storyboard instantiateViewControllerWithIdentifier:@"ItemListCollectionViewController"];
        
        self.viewController.childViewController = childViewController;
        
        //bind view controller
        childViewController.presenter = itemListCollectionPresenter;
        
        //bind presenter
        itemListCollectionPresenter.userInterface = childViewController;
        
    } else {
        
        MTItemListTableViewController *childViewController = [storyboard instantiateViewControllerWithIdentifier:@"ItemListTableViewController"];
        
        self.viewController.childViewController = childViewController;
        
        //bind view controller
        childViewController.presenter = itemListCollectionPresenter;
        
        //bind presenter
        itemListCollectionPresenter.userInterface = childViewController;
    }
}

@end
