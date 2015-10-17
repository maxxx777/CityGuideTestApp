//
//  MTRootTableViewController.m
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 07.10.15.
//  Copyright (c) 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTRootTableViewController.h"
#import "MTRootCollectionPresenterInterface.h"

@interface MTRootTableViewController ()

@end

@implementation MTRootTableViewController

- (void)dealloc
{
    DLog(@"%@ deallocated: %p", NSStringFromClass([self class]), self);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.sectionHeaderHeight = 0.0f;
    self.tableView.sectionFooterHeight = 0.0f;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    //FIXME: replace with more elegant solution
    if (IS_IPAD || [self.navigationController.viewControllers indexOfObject:self] == NSNotFound) {
        if ([self.presenter respondsToSelector:@selector(onWillCloseView)]) {
            [self.presenter onWillCloseView];
        }
    }
}

@end
