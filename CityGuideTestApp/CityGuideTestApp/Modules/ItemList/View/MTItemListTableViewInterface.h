//
//  MTItemListTableViewInterface.h
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 07.10.15.
//  Copyright (c) 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTRootTablePresenterInterface.h"

@protocol MTItemListTableViewInterface <NSObject, MTRootTablePresenterInterface>

- (void)updateFooterLabelWithText:(NSString *)text;
- (void)reloadData;
- (void)reloadDataAndScrollToRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)selectAndScrollToRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)deselectRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)reloadRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)configurePullToRefreshSubtitleWithText:(NSString *)text;
- (void)stopPullToRefreshAnimating;
- (void)clearLoadMoreValues;
- (void)startLoadCells;

@end
