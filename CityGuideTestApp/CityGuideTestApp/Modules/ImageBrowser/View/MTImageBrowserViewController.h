//
//  MTImageBrowserViewController.h
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 12.10.15.
//  Copyright © 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTRootViewController.h"
#import "MTImageBrowserViewInterface.h"
#import "MTImageBrowserPresenterInterface.h"

@interface MTImageBrowserViewController : MTRootViewController
<
    MTImageBrowserViewInterface,
    UIScrollViewDelegate
>

@property (nonatomic, strong) id<MTImageBrowserPresenterInterface> _Nonnull presenter;
@property (nonatomic, strong) IBOutlet UIImageView *imageView;

@end
