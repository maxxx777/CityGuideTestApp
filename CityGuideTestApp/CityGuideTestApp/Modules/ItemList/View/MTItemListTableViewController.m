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
    
    [self.presenter registerCellForTableView:self.tableView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
//    [UIView transitionWithView: self.tableView
//                      duration: 0.0f
//                       options: UIViewAnimationOptionTransitionNone
//                    animations: ^(void)
//     {
         [self.presenter onWillAppearView];
//     }
//                    completion: ^(BOOL isFinished)
//     {
//         [self reloadData];
//     }];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.presenter onDidAppearView];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    if ([self.navigationController.viewControllers indexOfObject:self] == NSNotFound) {
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
    return [self.presenter numberOfRowsInSection:section];
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return [self.presenter sectionIndexTitles];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [self.presenter titleForHeaderInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[self.presenter cellIdentifierForIndexPath:indexPath]];
    [self.presenter configureCell:cell
                      atIndexPath:indexPath
                      inTableView:tableView];
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[self.presenter cellIdentifierForIndexPath:indexPath]];
    
    CGFloat height = [self.presenter heightForCell:cell
                                       atIndexPath:indexPath
                                       inTableView:tableView];
    return height;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.presenter respondsToSelector:@selector(willDisplayCell:atIndexPath:inTableView:)]) {
        [self.presenter willDisplayCell:cell atIndexPath:indexPath inTableView:self.tableView];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!tableView.isEditing) {
        
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        
        [self.presenter didSelectRowAtIndexPath:indexPath];
        
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

- (void)insertRowsAtIndexPaths:(NSArray *)indexPaths
{
    [self.tableView beginUpdates];
    [self.tableView insertRowsAtIndexPaths:indexPaths
                          withRowAnimation:UITableViewRowAnimationAutomatic];
    [self.tableView endUpdates];
}

- (void)deleteRowsAtIndexPaths:(NSArray *)indexPaths
{
    [self.tableView beginUpdates];
    [self.tableView deleteRowsAtIndexPaths:indexPaths
                          withRowAnimation:UITableViewRowAnimationAutomatic];
    [self.tableView endUpdates];
}

@end
