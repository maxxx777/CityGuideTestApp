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
#import "MTCityListCell.h"
#import "MTPlaceListCell.h"
#import "MTAlertWrapper.h"

static NSString *MTCityListCellIdentifier = @"CityListCell";
static NSString *MTPlaceListCellIdentifier = @"PlaceListCell";
static NSString *MTOffScreenCityListCellIdentifier = @"OffScreenCityListCell";
static NSString *MTOffScreenPlaceListCellIdentifier = @"OffScreenPlaceListCell";

@interface MTItemListTablePresenter ()
{
    MTAlertWrapper *alertWrapper;
}

@property (nonatomic, strong) id<MTItemListRequesterInputInterface>itemListRequester;
@property (nonatomic, strong) id<MTItemListExpanderInputInterface>itemListExpander;
@property (nonatomic, weak) MTItemListWireframe *wireframe;
@property (nonatomic) BOOL isFirstAppearance;
@property (nonatomic, strong) MTCityListCell *prototypeCityListCell;
@property (nonatomic, strong) MTPlaceListCell *prototypePlaceListCell;

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
        [self.itemListRequester fetchAllItems];
    }
}

- (void)updateViewAfterAppearing
{
    
}

- (void)willCloseView
{
//    [self.itemListRequester cancelActions];
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
    if ([self.itemListExpander isCityObjectAtIndexPath:indexPath]) {
        MTCityListCell *cellToConfigure = (MTCityListCell *)cell;
        [cellToConfigure configureCellWithItem:item
                                      isOpened:[self.itemListExpander isOpenedCityAtIndexPath:indexPath]];
    } else {
        MTPlaceListCell *cellToConfigure = (MTPlaceListCell *)cell;
        [cellToConfigure configureCellWithItem:item];
    }
}

- (CGFloat)heightForCell:(UITableViewCell *)cell
             atIndexPath:(NSIndexPath *)indexPath
             inTableView:(UITableView *)tableView
{
    id item = [self.itemListExpander objectAtIndexPath:indexPath];
    
    if ([self.itemListExpander isCityObjectAtIndexPath:indexPath]) {
        if (!self.prototypeCityListCell) {
            self.prototypeCityListCell = [tableView dequeueReusableCellWithIdentifier:MTOffScreenCityListCellIdentifier];
        }
        
        return [self.prototypeCityListCell heightForCellWithItem:item];
    } else {
        if (!self.prototypePlaceListCell) {
            self.prototypePlaceListCell = [tableView dequeueReusableCellWithIdentifier:MTOffScreenPlaceListCellIdentifier];
        }
        
        return [self.prototypePlaceListCell heightForCellWithItem:item];
    }
}

- (void)didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.itemListExpander isCityObjectAtIndexPath:indexPath]) {
        [self.itemListExpander openOrCloseCityAtIndexPath:indexPath];
    } else {
        id item = [self.itemListExpander objectAtIndexPath:indexPath];
        [self.wireframe onDidSelectItem:item];
    }
}

- (void)registerCellForTableView:(UITableView *)tableView
{
    [tableView registerClass:[MTCityListCell class]
      forCellReuseIdentifier:MTCityListCellIdentifier];
    [tableView registerClass:[MTCityListCell class]
      forCellReuseIdentifier:MTOffScreenCityListCellIdentifier];
    [tableView registerClass:[MTPlaceListCell class]
      forCellReuseIdentifier:MTPlaceListCellIdentifier];
    [tableView registerClass:[MTPlaceListCell class]
      forCellReuseIdentifier:MTOffScreenPlaceListCellIdentifier];
}

- (NSString *)cellIdentifierForIndexPath:(NSIndexPath *)indexPath
{
    if ([self.itemListExpander isCityObjectAtIndexPath:indexPath]) {
        return MTCityListCellIdentifier;
    } else {
        return MTPlaceListCellIdentifier;
    }
}

#pragma mark - MTItemListFetcherOutputInterface

- (void)onDidFetchItemsWithError:(NSError *)error
{
    [self.itemListExpander onDidUpdateItemList];
    
    self.isFirstAppearance = NO;
    if (!error) {
        
        [self reloadView];
        
    } else {
        [alertWrapper showRepeatRequestAlertInViewController:self.userInterface withTitle:NSLocalizedString(@"Error", nil) message:NSLocalizedString(@"Sorry, can't receive countries from server", nil)
                                           clickedCompletion:^(NSInteger buttonIndex, NSString *actionTitle, NSString *inputText){
                                               if (buttonIndex == 1) {
//                                                   [self.itemListRequester refreshItems];
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
    if ([self.itemListExpander numberOfRows] == 0) {
        [self.userInterface updateFooterLabelWithText:NSLocalizedString(@"There are no places", nil)];
    } else {
        [self.userInterface updateFooterLabelWithText:@""];
    }
    
    [self.userInterface reloadData];
}

@end
