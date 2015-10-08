//
//  MTRootTableViewController.h
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 07.10.15.
//  Copyright (c) 2015 MAXIM TSVETKOV. All rights reserved.
//

@protocol MTRootTablePresenterInterface;

@interface MTRootTableViewController : UITableViewController

@property (nonatomic, strong) id<MTRootTablePresenterInterface> presenter;

@end
