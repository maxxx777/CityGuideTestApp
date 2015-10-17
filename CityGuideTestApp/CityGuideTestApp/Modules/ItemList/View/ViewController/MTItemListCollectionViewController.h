//
//  MTItemListCollectionViewController.h
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 16.10.15.
//  Copyright © 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTRootCollectionViewController.h"
#import "MTItemListCollectionViewInterface.h"
#import "MTItemListCollectionPresenterInterface.h"

@class MTTableFooterView;

@interface MTItemListCollectionViewController : MTRootCollectionViewController
<
    MTItemListCollectionViewInterface,
    UICollectionViewDelegateFlowLayout
>

@property (nonatomic, strong) IBOutlet MTTableFooterView *tableFooterView;
@property (nonatomic, strong) id<MTItemListCollectionPresenterInterface> presenter;

@end