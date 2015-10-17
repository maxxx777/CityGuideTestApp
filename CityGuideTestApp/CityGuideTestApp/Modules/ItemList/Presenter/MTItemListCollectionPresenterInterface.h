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
- (NSString *)sectionIndexTitleForSectionName:(NSString *)sectionName;
- (NSString *)titleForHeaderInSection:(NSInteger)section;

- (void)configureCell:(UIView *)cell
          atIndexPath:(NSIndexPath *)indexPath;
- (CGSize)sizeForCellAtIndexPath:(NSIndexPath *)indexPath;

- (void)didSelectItemAtIndexPath:(NSIndexPath *)indexPath
                        fromRect:(CGRect)rect;

- (NSString *)cellIdentifierForIndexPath:(NSIndexPath *)indexPath;
- (void)registerCellForTableView:(UITableView *)tableView;
- (void)registerCellForCollectionView:(UICollectionView *)collectionView;

@end
