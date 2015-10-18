//
//  MTItemListTableViewController.h
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 07.10.15.
//  Copyright (c) 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTRootTableViewController.h"
#import "MTItemListCollectionViewInterface.h"
#import "MTItemListCollectionPresenterInterface.h"

@class MTTableFooterView;

@interface MTItemListTableViewController : MTRootTableViewController
<
    MTItemListCollectionViewInterface
>

@property (nonatomic, strong) IBOutlet MTTableFooterView *tableFooterView;
@property (nonatomic, strong) id<MTItemListCollectionPresenterInterface> _Nonnull presenter;

@end
