//
//  MTImageBrowserViewController.m
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 12.10.15.
//  Copyright © 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTImageBrowserViewController.h"
#import "MTImageBrowserPresenterInterface.h"
#import "NSString+MTFormatting.h"

@implementation MTImageBrowserViewController
@synthesize presenter = _presenter;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if ([self.presenter respondsToSelector:@selector(onDidLoadView)]) {
        [self.presenter onDidLoadView];
    }    
}

#pragma mark - MTImageBrowserViewInterface

- (void)configureImageWithImage:(UIImage *)image
{
    self.imageView.image = image;
}

- (void)configureNavigationBarWithTitle:(NSString *)title
{
    self.navigationItem.title = title;
}

#pragma mark - UIScrollViewDelegate

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}

@end
