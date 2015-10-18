//
//  MTItemListTablePresenter.m
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 07.10.15.
//  Copyright (c) 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTItemListCollectionPresenter.h"
#import "MTItemListCollectionViewInterface.h"
#import "MTItemListWireframe.h"
#import "MTCityListTableViewCell.h"
#import "MTPlaceListTableViewCell.h"
#import "MTCityListCollectionViewCell.h"
#import "MTPlaceListCollectionViewCell.h"
#import "MTPlaceListCellInterface.h"
#import "MTAlertWrapper.h"

static NSString *MTCityListCellIdentifier = @"CityListCell";
static NSString *MTPlaceListCellIdentifier = @"PlaceListCell";

@interface MTItemListCollectionPresenter ()
{
    MTAlertWrapper *alertWrapper;
}

@property (nonatomic, strong) id<MTItemListRequesterInputInterface>itemListRequester;
@property (nonatomic, strong) id<MTItemListExpanderInputInterface>itemListExpander;
@property (nonatomic, weak) MTItemListWireframe *wireframe;
@property (nonatomic) BOOL isFirstAppearance;
@property (nonatomic, strong) MTCityListTableViewCell *prototypeCityListCell;
@property (nonatomic, strong) MTPlaceListTableViewCell *prototypePlaceListCell;

@end

@implementation MTItemListCollectionPresenter

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

- (UIViewController<MTItemListCollectionViewInterface> *)userInterface
{
    NSAssert(_userInterface != nil, @"userInterface is equal to nil");
    return _userInterface;
}

#pragma mark - MTItemListTablePresenterInterface

- (void)onWillAppearView
{
    if (self.isFirstAppearance) {
        [self.userInterface updateFooterLabelWithText:@"Data Loading..."];
        [self.itemListRequester fetchAllItems];
    }
}

- (void)onDidRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [self.userInterface reloadData];
}

- (NSUInteger)numberOfSections
{
    return 1;
}

- (NSUInteger)numberOfItemsInSection:(NSInteger)section
{
    return [self.itemListExpander numberOfRows];
}

- (void)configureCell:(UIView *)cell
          atIndexPath:(NSIndexPath *)indexPath
{
    id item = [self.itemListExpander objectAtIndexPath:indexPath];
    if ([self.itemListExpander isCityObjectAtIndexPath:indexPath]) {
        UIView<MTCityListCellInterface> *cellToConfigure = (UIView <MTCityListCellInterface> *)cell;
        [cellToConfigure mt_configureCellWithItem:item
                                         isOpened:[self.itemListExpander isOpenedCityAtIndexPath:indexPath]];
    } else {
        UIView<MTPlaceListCellInterface> *cellToConfigure = (UIView <MTPlaceListCellInterface> *)cell;
        [cellToConfigure mt_configureCellWithItem:item];
    }
}

- (CGSize)sizeForCellAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.itemListExpander isCityObjectAtIndexPath:indexPath]) {
        return CGSizeMake([UIScreen mainScreen].bounds.size.width, 44.0f);
    } else {
        return IS_IPAD ? CGSizeMake(260.0f, 260.0f) : CGSizeMake([UIScreen mainScreen].bounds.size.width, 60.0f);
    }
}

- (void)didSelectItemAtIndexPath:(NSIndexPath *)indexPath
                        fromRect:(CGRect)rect
{
    if ([self.itemListExpander isCityObjectAtIndexPath:indexPath]) {
        [self.itemListExpander openOrCloseCityAtIndexPath:indexPath];
        
        if ([self.itemListExpander isOpenedCityAtIndexPath:indexPath]) {
            [self.userInterface selectItemAtIndexPath:indexPath];
        } else {
            [self.userInterface deselectItemAtIndexPath:indexPath];
        }
    } else {
        [self.userInterface deselectItemAtIndexPath:indexPath];
        
        id item = [self.itemListExpander objectAtIndexPath:indexPath];
        
        [self.wireframe onDidSelectItem:item
                               fromRect:rect];
    }
}

- (void)registerCellForCollectionView:(UICollectionView *)collectionView
{
    [collectionView registerClass:[MTCityListCollectionViewCell class]
       forCellWithReuseIdentifier:MTCityListCellIdentifier];
    [collectionView registerClass:[MTPlaceListCollectionViewCell class]
       forCellWithReuseIdentifier:MTPlaceListCellIdentifier];
}

- (void)registerCellForTableView:(UITableView *)tableView
{
    [tableView registerClass:[MTCityListTableViewCell class]
      forCellReuseIdentifier:MTCityListCellIdentifier];
    [tableView registerClass:[MTPlaceListTableViewCell class]
      forCellReuseIdentifier:MTPlaceListCellIdentifier];
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
    [self.itemListExpander closeAllCities];
    
    if (self.isFirstAppearance) {
        self.isFirstAppearance = NO;
    }
    
    if (error) {

        [alertWrapper showErrorAlertInViewController:self.userInterface
                                         withMessage:NSLocalizedString(@"Sorry, can't receive products", nil)];
    }
}

#pragma mark - MTItemListExpanderOutputInterface

- (void)onDidOpenCityPlacesAtIndexPaths:(NSArray *)indexPaths
{
    [self.userInterface insertItemsAtIndexPaths:indexPaths];
}

- (void)onDidCloseCityPlacesAtIndexPaths:(NSArray *)indexPaths
{
    [self.userInterface deleteItemsAtIndexPaths:indexPaths];
}

- (void)onDidCloseAllCities
{
    //FIXME: don't close opened cities after new place was added or places were filtered
    [self reloadView];
}

#pragma mark - Helper

- (void)reloadView
{
    if ([self.itemListExpander numberOfRows] == 0) {
        [self.userInterface updateFooterLabelWithText:NSLocalizedString(@"There are no places", nil)];
    } else {
        [self.userInterface updateFooterLabelWithText:@""];
    }
    
    //FIXME: don't reload whole table/collection view. use insert/feload/delete items.
    [self.userInterface reloadData];
}

@end
