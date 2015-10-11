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
- (void)insertRowsAtIndexPaths:(NSArray *)indexPaths;
- (void)deleteRowsAtIndexPaths:(NSArray *)indexPaths;

@end
