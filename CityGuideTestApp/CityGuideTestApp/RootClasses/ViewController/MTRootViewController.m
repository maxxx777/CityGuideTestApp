//
//  MTRootViewController.m
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 07.10.15.
//  Copyright (c) 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTRootViewController.h"
#import "MTRootPresenterInterface.h"

@interface MTRootViewController ()

@end

@implementation MTRootViewController

- (void)dealloc
{
    DLog(@"%@ deallocated: %p", NSStringFromClass([self class]), self);
}

- (void)viewDidLoad
{
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    [super viewDidLoad];
}

- (void)configureNavigationBarWithTitle:(NSString *)title
{
    self.navigationItem.title = title;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    if ([self.navigationController.viewControllers indexOfObject:self] == NSNotFound) {
        if ([self.presenter respondsToSelector:@selector(onWillCloseView)]) {
            [self.presenter onWillCloseView];
        }
    }
}

@end
