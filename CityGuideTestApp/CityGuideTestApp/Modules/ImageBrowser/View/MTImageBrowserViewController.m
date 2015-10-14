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
    [self.presenter onDidLoadView];
}

#pragma mark - MTImageBrowserViewInterface

- (void)configureImageWithFileName:(NSString *)fileName
{
    NSString *filePath = [fileName mt_formatDocumentsPath];
    UIImage *image = [UIImage imageWithContentsOfFile:filePath];

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
