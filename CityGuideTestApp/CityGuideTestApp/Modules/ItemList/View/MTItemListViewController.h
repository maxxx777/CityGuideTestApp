//
//  MTItemListViewController.h
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 07.10.15.
//  Copyright (c) 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTRootViewController.h"
#import "MTItemListViewInterface.h"
#import "MTItemListPresenterInterface.h"

@class MTItemListTableViewController;

@interface MTItemListViewController : MTRootViewController
<
    MTItemListViewInterface
>

@property (nonatomic, strong) IBOutlet UIView *containerView;
@property (nonatomic, strong) IBOutlet UIBarButtonItem *barButtonFilter;
@property (nonatomic, strong) MTItemListTableViewController *childTableViewController;
@property (nonatomic, strong) id<MTItemListPresenterInterface> presenter;

@end
