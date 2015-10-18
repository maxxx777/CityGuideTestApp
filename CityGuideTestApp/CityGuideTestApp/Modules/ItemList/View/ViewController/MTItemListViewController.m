//
//  MTItemListViewController.m
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 07.10.15.
//  Copyright (c) 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTItemListViewController.h"
#import "MTItemListTableViewController.h"
#import "MTItemListCollectionViewController.h"

@interface MTItemListViewController ()

@end

@implementation MTItemListViewController
@synthesize presenter = _presenter;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if ([self.presenter respondsToSelector:@selector(onDidLoadView)]) {
        [self.presenter onDidLoadView];
    }
    [self configureChildViewController];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}

#pragma mark - IB Actions

- (IBAction)addButtonPressed:(id)sender
{
    if ([self.presenter respondsToSelector:@selector(onDidPressRightBarButtonOnNavigationBar)]) {
        [self.presenter onDidPressRightBarButtonOnNavigationBar];
    }
}

- (IBAction)filterButtonPressed:(id)sender
{
    if ([self.presenter respondsToSelector:@selector(onDidPressRightBarButtonOnToolbar:)]) {
        [self.presenter onDidPressRightBarButtonOnToolbar:sender];
    }    
}

#pragma mark - Helper 

- (void)configureChildViewController
{
    UIView *childView = self.childViewController.view;
    
    [self addChildViewController:self.childViewController];
    [self.containerView addSubview:childView];
    
    [childView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.containerView addConstraints:[NSLayoutConstraint
                                        constraintsWithVisualFormat:@"H:|-0-[childView]-0-|"
                                        options:NSLayoutFormatDirectionLeadingToTrailing
                                        metrics:nil
                                        views:NSDictionaryOfVariableBindings(childView)]];
    [self.containerView addConstraints:[NSLayoutConstraint
                                        constraintsWithVisualFormat:@"V:|-0-[childView]-0-|"
                                        options:NSLayoutFormatDirectionLeadingToTrailing
                                        metrics:nil
                                        views:NSDictionaryOfVariableBindings(childView)]];
    
    [self.childViewController didMoveToParentViewController:self];
}

#pragma mark - MTItemListViewInterface

- (void)configureBarButtonFilterWithTitle:(NSString *)title
{
    self.barButtonFilter.title = title;
}

@end
