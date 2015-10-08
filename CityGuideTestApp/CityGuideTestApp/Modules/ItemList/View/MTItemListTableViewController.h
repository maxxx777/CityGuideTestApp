//
//  MTItemListTableViewController.h
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 07.10.15.
//  Copyright (c) 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTRootTableViewController.h"
#import "MTItemListTableViewInterface.h"
#import "MTItemListTablePresenterInterface.h"

@class MTTableFooterView;

@interface MTItemListTableViewController : MTRootTableViewController
<
    MTItemListTableViewInterface,
    UIScrollViewDelegate
>

@property (nonatomic, strong) IBOutlet MTTableFooterView *tableFooterView;
@property (nonatomic, strong) id<MTItemListTablePresenterInterface> presenter;
@property (nonatomic) BOOL enablePullToRefresh;
@property (nonatomic) BOOL enableIndexedList;
@property (nonatomic) BOOL enableLoadMore;

@end
