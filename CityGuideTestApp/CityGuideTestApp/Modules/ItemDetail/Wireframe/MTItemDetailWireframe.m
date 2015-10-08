//
//  MTItemDetailWireframe.m
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 07.10.15.
//  Copyright (c) 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTItemDetailWireframe.h"
#import "MTItemListViewController.h"

@interface MTItemDetailWireframe ()

@property (nonatomic, weak) MTItemListViewController *viewController;

@end

@implementation MTItemDetailWireframe

#pragma mark - MTCityListModuleInterface

- (void)showItemDetailsForItem:(id)item
          navigationController:(UINavigationController *)navigationController
{
    //init
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Base" bundle: nil];
    _viewController = [storyboard instantiateViewControllerWithIdentifier:@"ItemListViewControllerWithSearch"];
    
    //configure
    [self configureStackWithItem:item];
    
    //navigate
    [navigationController pushViewController:self.viewController
                                    animated:YES];
}

#pragma mark - Helper

- (void)configureStackWithItem:(id)item
{

}

@end
