//
//  MTItemListViewController.m
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 07.10.15.
//  Copyright (c) 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTItemListViewController.h"
#import "MTItemListTableViewController.h"

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
    [self configureChildTableViewController];
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
    if ([self.presenter respondsToSelector:@selector(onDidPressLeftBarButtonOnNavigationBar)]) {
        [self.presenter onDidPressRightBarButtonOnNavigationBar];
    }
}

- (IBAction)filterButtonPressed:(id)sender
{
    if ([self.presenter respondsToSelector:@selector(onDidPressLeftBarButtonOnToolbar)]) {
        [self.presenter onDidPressRightBarButtonOnToolbar];
    }    
}

#pragma mark - Helper 

- (void)configureChildTableViewController
{
    UIView *tableView = self.childTableViewController.tableView;
    
    [self addChildViewController:self.childTableViewController];
    [self.containerView addSubview:tableView];
    
    [tableView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.containerView addConstraints:[NSLayoutConstraint
                                        constraintsWithVisualFormat:@"H:|-0-[tableView]-0-|"
                                        options:NSLayoutFormatDirectionLeadingToTrailing
                                        metrics:nil
                                        views:NSDictionaryOfVariableBindings(tableView)]];
    [self.containerView addConstraints:[NSLayoutConstraint
                                        constraintsWithVisualFormat:@"V:|-0-[tableView]-0-|"
                                        options:NSLayoutFormatDirectionLeadingToTrailing
                                        metrics:nil
                                        views:NSDictionaryOfVariableBindings(tableView)]];
    
    [self.childTableViewController didMoveToParentViewController:self];
}

#pragma mark - MTItemListViewInterface

- (void)configureBarButtonFilterWithTitle:(NSString *)title
{
    self.barButtonFilter.title = title;
}

@end
