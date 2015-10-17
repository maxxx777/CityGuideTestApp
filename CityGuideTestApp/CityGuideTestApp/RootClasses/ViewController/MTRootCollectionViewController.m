//
//  MTRootCollectionViewController.m
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 16.10.15.
//  Copyright © 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTRootCollectionViewController.h"
#import "MTRootCollectionPresenterInterface.h"

@interface MTRootCollectionViewController ()

@end

@implementation MTRootCollectionViewController

- (void)dealloc
{
    DLog(@"%@ deallocated: %p", NSStringFromClass([self class]), self);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    self.tableView.sectionHeaderHeight = 0.0f;
//    self.tableView.sectionFooterHeight = 0.0f;
}

@end
