//
//  MTItemListTableViewController.m
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 07.10.15.
//  Copyright (c) 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTItemListTableViewController.h"
#import "MTTableFooterView.h"

@interface MTItemListTableViewController ()

@end

@implementation MTItemListTableViewController
@synthesize presenter = _presenter;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if ([self.presenter respondsToSelector:@selector(onDidLoadView)]) {
        [self.presenter onDidLoadView];
    }
    
    [self.presenter registerCellForTableView:self.tableView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if ([self.presenter respondsToSelector:@selector(onWillAppearView)]) {
        [self.presenter onWillAppearView];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if ([self.presenter respondsToSelector:@selector(onDidAppearView)]) {
        [self.presenter onDidAppearView];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    if ([self.presenter respondsToSelector:@selector(onWillDisappearView)]) {
        [self.presenter onWillDisappearView];
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.presenter numberOfSections];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.presenter numberOfItemsInSection:section];
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    if ([self.presenter respondsToSelector:@selector(sectionIndexTitles)]) {
        return [self.presenter sectionIndexTitles];
    } else {
        return nil;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if ([self.presenter respondsToSelector:@selector(titleForHeaderInSection:)]) {
        return [self.presenter titleForHeaderInSection:section];
    } else {
        return nil;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    
    if ([self.presenter respondsToSelector:@selector(cellIdentifierForIndexPath:)]) {
        cell = [tableView dequeueReusableCellWithIdentifier:[self.presenter cellIdentifierForIndexPath:indexPath]];
        if ([self.presenter respondsToSelector:@selector(configureCell:atIndexPath:)]) {
            [self.presenter configureCell:cell
                              atIndexPath:indexPath];
        }
    }

    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.0f;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 0.0f;
    if ([self.presenter respondsToSelector:@selector(sizeForCellAtIndexPath:)]) {
        height = [self.presenter sizeForCellAtIndexPath:indexPath].height;
    }
    return height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.presenter respondsToSelector:@selector(didSelectItemAtIndexPath:fromRect:)]) {
        [self.presenter didSelectItemAtIndexPath:indexPath
                                        fromRect:CGRectZero];
    }
}

#pragma mark - MTItemListTableViewInterface

- (void)updateFooterLabelWithText:(NSString *)text
{
    [self.tableFooterView setTitle:text];
}

- (void)reloadData
{
    [self.tableView reloadData];
}

- (void)insertItemsAtIndexPaths:(NSArray *)indexPaths
{
    [self.tableView beginUpdates];
    [self.tableView insertRowsAtIndexPaths:indexPaths
                          withRowAnimation:UITableViewRowAnimationAutomatic];
    [self.tableView endUpdates];
}

- (void)reloadItemsAtIndexPaths:(NSArray *)indexPaths
{
    [self.tableView beginUpdates];
    [self.tableView reloadRowsAtIndexPaths:indexPaths
                          withRowAnimation:UITableViewRowAnimationAutomatic];
    [self.tableView endUpdates];
}

- (void)deleteItemsAtIndexPaths:(NSArray *)indexPaths
{
    [self.tableView beginUpdates];
    [self.tableView deleteRowsAtIndexPaths:indexPaths
                          withRowAnimation:UITableViewRowAnimationAutomatic];
    [self.tableView endUpdates];
}

- (void)selectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionMiddle];
}

- (void)deselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
