//
//  MTItemListTableViewInterface.h
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 07.10.15.
//  Copyright (c) 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTRootCollectionPresenterInterface.h"

@protocol MTItemListCollectionViewInterface <NSObject, MTRootCollectionPresenterInterface>

- (void)updateFooterLabelWithText:(NSString *)text;
- (void)reloadData;
- (void)insertItemsAtIndexPaths:(NSArray *)indexPaths;
- (void)reloadItemsAtIndexPaths:(NSArray *)indexPaths;
- (void)deleteItemsAtIndexPaths:(NSArray *)indexPaths;
- (void)selectItemAtIndexPath:(NSIndexPath *)indexPath;
- (void)deselectItemAtIndexPath:(NSIndexPath *)indexPath;

@end
