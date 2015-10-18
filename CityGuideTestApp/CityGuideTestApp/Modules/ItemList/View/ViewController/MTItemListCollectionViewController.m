//
//  MTItemListCollectionViewController.m
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 16.10.15.
//  Copyright © 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTItemListCollectionViewController.h"
#import "MTTableFooterView.h"

@interface MTItemListCollectionViewController ()

@end

@implementation MTItemListCollectionViewController
@synthesize presenter = _presenter;

- (void)viewDidLoad
{
    [super viewDidLoad];

    if ([self.presenter respondsToSelector:@selector(onDidLoadView)]) {
        [self.presenter onDidLoadView];
    }
    
    self.collectionView.allowsSelection = YES;
    self.collectionView.allowsMultipleSelection = YES;
    
    [self.presenter registerCellForCollectionView:self.collectionView];
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

#pragma mark - Orientation

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    if ([self.presenter respondsToSelector:@selector(onDidRotateFromInterfaceOrientation:)]) {
        [self.presenter onDidRotateFromInterfaceOrientation:fromInterfaceOrientation];
    }
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return [self.presenter numberOfSections];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.presenter numberOfItemsInSection:section];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell;
    
    if ([self.presenter respondsToSelector:@selector(cellIdentifierForIndexPath:)]) {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:[self.presenter cellIdentifierForIndexPath:indexPath] forIndexPath:indexPath];
        
        if ([self.presenter respondsToSelector:@selector(configureCell:atIndexPath:)]) {
            [self.presenter configureCell:cell
                              atIndexPath:indexPath];
        }
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.presenter respondsToSelector:@selector(didSelectItemAtIndexPath:fromRect:)]) {
        UICollectionViewLayoutAttributes *attributes = [self.collectionView layoutAttributesForItemAtIndexPath:indexPath];
        CGRect rect = attributes.frame;
        rect = [collectionView convertRect:rect toView:collectionView.superview];
        [self.presenter didSelectItemAtIndexPath:indexPath
                                        fromRect:rect];
    }
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize size = CGSizeZero;
    if ([self.presenter respondsToSelector:@selector(sizeForCellAtIndexPath:)]) {
        size = [self.presenter sizeForCellAtIndexPath:indexPath];
    }
    return size;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.0f;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.0f;
}

#pragma mark - MTItemListTableViewInterface

- (void)updateFooterLabelWithText:(NSString *)text
{
    [self.tableFooterView setTitle:text];
}

- (void)reloadData
{
    [self.collectionView reloadData];
}

- (void)insertItemsAtIndexPaths:(NSArray *)indexPaths
{
    [self.collectionView performBatchUpdates:^{
        [self.collectionView insertItemsAtIndexPaths:indexPaths];
    } completion:nil];
}

- (void)reloadItemsAtIndexPaths:(NSArray *)indexPaths
{
    [self.collectionView performBatchUpdates:^{
        [self.collectionView reloadItemsAtIndexPaths:indexPaths];
    } completion:nil];
}

- (void)deleteItemsAtIndexPaths:(NSArray *)indexPaths
{
    [self.collectionView performBatchUpdates:^{
        [self.collectionView deleteItemsAtIndexPaths:indexPaths];
    } completion:nil];        
}

- (void)selectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self.collectionView selectItemAtIndexPath:indexPath animated:YES scrollPosition:UICollectionViewScrollPositionNone];
}

- (void)deselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self.collectionView deselectItemAtIndexPath:indexPath animated:YES];
}

@end
