//
//  MTItemListTablePresenter.m
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 07.10.15.
//  Copyright (c) 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTItemListTablePresenter.h"
#import "MTItemListTableViewInterface.h"
#import "MTItemListWireframe.h"
#import "MTItemListCell.h"
#import "MTAlertWrapper.h"

static NSString *MTOffScreenCellIdentifier = @"OffScreenTableViewCell";
static NSString *MTTableViewCellIdentifier = @"TableViewCellIdentifier";

@interface MTItemListTablePresenter ()
{
    MTAlertWrapper *alertWrapper;
}

@property (nonatomic, strong) id<MTItemListRequesterInputInterface>itemListRequester;
@property (nonatomic, strong) id<MTItemListExpanderInputInterface>itemListExpander;
@property (nonatomic, weak) MTItemListWireframe *wireframe;
@property (nonatomic) BOOL isFirstAppearance;
@property (nonatomic, strong) MTItemListCell *prototypeCell;

@end

@implementation MTItemListTablePresenter

- (instancetype)initWithItemListRequester:(id<MTItemListRequesterInputInterface>)itemListRequester
                         itemListExpander:(id<MTItemListExpanderInputInterface>)itemListExpander
                                wireframe:(MTItemListWireframe *)wireframe
{
    self = [super init];
    if (self) {
        
        _itemListRequester = itemListRequester;
        _itemListExpander = itemListExpander;
        _wireframe = wireframe;
        
        alertWrapper = [[MTAlertWrapper alloc] init];
        
        _isFirstAppearance = YES;
        
    }
    return self;
}

#pragma mark - MTItemListTablePresenterInterface

- (void)updateViewBeforeAppearing
{
    if (self.isFirstAppearance) {
        [self.userInterface updateFooterLabelWithText:@"Data Loading..."];
        [self.itemListRequester fetchItems];
    }
}

- (void)updateViewAfterAppearing
{
    
}

- (void)refreshContent
{
    [self.itemListRequester refreshItems];
}

- (void)willCloseView
{
    [self.itemListRequester cancelActions];
}

- (void)scrollViewWithOffset:(CGPoint)offset
{
    
}

- (NSUInteger)numberOfSections
{
    return 1;
}

- (NSUInteger)numberOfRowsInSection:(NSInteger)section
{
    return [self.itemListExpander numberOfRows];
}

- (NSArray *)sectionIndexTitles
{
    return nil;
}

- (NSString *)sectionIndexTitleForSectionName:(NSString *)sectionName
{
    return nil;
}

- (NSString *)titleForHeaderInSection:(NSInteger)section
{
    return nil;
}

- (void)configureCell:(UITableViewCell *)cell
          atIndexPath:(NSIndexPath *)indexPath
          inTableView:(UITableView *)tableView
{
    id item = [self.itemListExpander objectAtIndexPath:indexPath];
    MTItemListCell *cellToConfigure = (MTItemListCell *)cell;
    [cellToConfigure configureCellWithItem:item];
}

- (CGFloat)heightForCell:(UITableViewCell *)cell
             atIndexPath:(NSIndexPath *)indexPath
             inTableView:(UITableView *)tableView
{
    return 60.0f;
    if (!self.prototypeCell) {
        self.prototypeCell = [tableView dequeueReusableCellWithIdentifier:MTOffScreenCellIdentifier];
    }
    
    id item = [self.itemListExpander objectAtIndexPath:indexPath];
    
    return [self.prototypeCell heightForCellWithItem:item];
}

- (void)didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.itemListExpander openOrCloseCityAtIndexPath:indexPath];
    
//    [self.wireframe onDidSelectItem:item];
}

- (void)registerCellForTableView:(UITableView *)tableView
{
    [tableView registerClass:[MTItemListCell class]
      forCellReuseIdentifier:MTTableViewCellIdentifier];
    [tableView registerClass:[MTItemListCell class]
      forCellReuseIdentifier:MTOffScreenCellIdentifier];
}

- (NSString *)cellIdentifierForIndexPath:(NSIndexPath *)indexPath
{
    return MTTableViewCellIdentifier;
}

#pragma mark - MTItemListFetcherOutputInterface

- (void)onDidFetchItemsWithError:(NSError *)error
{
    self.isFirstAppearance = NO;
    if (!error) {
        
        [self reloadView];
        
    } else {
        [alertWrapper showRepeatRequestAlertInViewController:self.userInterface withTitle:NSLocalizedString(@"Error", nil) message:NSLocalizedString(@"Sorry, can't receive countries from server", nil)
                                           clickedCompletion:^(NSInteger buttonIndex, NSString *actionTitle, NSString *inputText){
                                               if (buttonIndex == 1) {
                                                   [self.itemListRequester refreshItems];
                                               } else {
                                                   [self.userInterface stopPullToRefreshAnimating];
                                                   [self reloadView];
                                               }
                                           } didDismissCompletion:nil];
    }
    [self.userInterface stopPullToRefreshAnimating];
}

#pragma mark - MTItemListExpanderOutputInterface

- (void)onDidOpenCityPlacesAtIndexPaths:(NSArray *)indexPaths
{
    [self.userInterface insertRowsAtIndexPaths:indexPaths];
}

- (void)onDidCloseCityPlacesAtIndexPaths:(NSArray *)indexPaths
{
    [self.userInterface deleteRowsAtIndexPaths:indexPaths];
}

#pragma mark - Helper

- (void)reloadView
{
    [self.userInterface updateFooterLabelWithText:@""];
    [self.userInterface reloadData];
}

@end
