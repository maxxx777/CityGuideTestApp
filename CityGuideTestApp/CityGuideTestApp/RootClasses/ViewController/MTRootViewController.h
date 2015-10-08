//
//  MTRootViewController.h
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 07.10.15.
//  Copyright (c) 2015 MAXIM TSVETKOV. All rights reserved.
//

@protocol MTRootPresenterInterface;

@interface MTRootViewController : UIViewController

@property (nonatomic, strong) id<MTRootPresenterInterface> presenter;

@end
