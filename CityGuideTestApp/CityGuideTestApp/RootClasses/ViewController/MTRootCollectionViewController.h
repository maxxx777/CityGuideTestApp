//
//  MTRootCollectionViewController.h
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 16.10.15.
//  Copyright © 2015 MAXIM TSVETKOV. All rights reserved.
//

@protocol MTRootCollectionPresenterInterface;

@interface MTRootCollectionViewController : UICollectionViewController

@property (nonatomic, strong) id<MTRootCollectionPresenterInterface> presenter;

@end