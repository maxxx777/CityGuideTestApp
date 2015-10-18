//
//  MTItemListTableViewInterface.h
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 07.10.15.
//  Copyright (c) 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTRootCollectionPresenterInterface.h"

@protocol MTItemListCollectionViewInterface <NSObject, MTRootCollectionPresenterInterface>

- (void)updateFooterLabelWithText:(NSString * _Nonnull)text;
- (void)reloadData;
- (void)insertItemsAtIndexPaths:(NSArray * _Nonnull)indexPaths;
- (void)reloadItemsAtIndexPaths:(NSArray * _Nonnull)indexPaths;
- (void)deleteItemsAtIndexPaths:(NSArray * _Nonnull)indexPaths;
- (void)selectItemAtIndexPath:(NSIndexPath * _Nonnull)indexPath;
- (void)deselectItemAtIndexPath:(NSIndexPath * _Nonnull)indexPath;

@end
