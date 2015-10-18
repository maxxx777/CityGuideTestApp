//
//  MTItemListTablePresenterInterface.h
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 07.10.15.
//  Copyright (c) 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTRootCollectionPresenterInterface.h"

@protocol MTItemListCollectionPresenterInterface <NSObject, MTRootCollectionPresenterInterface>

@property (NS_NONATOMIC_IOSONLY, readonly) NSUInteger numberOfSections;
- (NSUInteger)numberOfItemsInSection:(NSInteger)section;

@optional

@property (NS_NONATOMIC_IOSONLY, readonly, copy) NSArray *sectionIndexTitles;
- (NSString *)sectionIndexTitleForSectionName:(NSString * _Nonnull)sectionName;
- (NSString *)titleForHeaderInSection:(NSInteger)section;

- (void)configureCell:(UIView * _Nonnull)cell
          atIndexPath:(NSIndexPath * _Nonnull)indexPath;
- (CGSize)sizeForCellAtIndexPath:(NSIndexPath * _Nonnull)indexPath;

- (void)didSelectItemAtIndexPath:(NSIndexPath * _Nonnull)indexPath
                        fromRect:(CGRect)rect;

- (NSString *)cellIdentifierForIndexPath:(NSIndexPath * _Nonnull)indexPath;
- (void)registerCellForTableView:(UITableView * _Nonnull)tableView;
- (void)registerCellForCollectionView:(UICollectionView * _Nonnull)collectionView;

@end
