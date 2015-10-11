//
//  MTItemListTablePresenterInterface.h
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 07.10.15.
//  Copyright (c) 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTRootTablePresenterInterface.h"

@protocol MTItemListTablePresenterInterface <NSObject, MTRootTablePresenterInterface>

@optional

- (void)scrollViewWithOffset: (CGPoint)offset;

- (NSUInteger)numberOfAllItemsOfSelectedType;
- (NSUInteger)numberOfSections;
- (NSUInteger)numberOfRowsInSection:(NSInteger)section;
- (NSArray *)sectionIndexTitles;
- (NSString *)sectionIndexTitleForSectionName:(NSString *)sectionName;
- (NSString *)titleForHeaderInSection:(NSInteger)section;
- (void)configureCell:(UITableViewCell *)cell
          atIndexPath:(NSIndexPath *)indexPath
          inTableView:(UITableView *)tableView;
- (CGFloat)heightForCell:(UITableViewCell *)cell
             atIndexPath:(NSIndexPath *)indexPath
             inTableView:(UITableView *)tableView;
- (void)willDisplayCell:(UITableViewCell *)cell
            atIndexPath:(NSIndexPath *)indexPath
            inTableView:(UITableView *)tableView;
- (void)didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)registerCellForTableView:(UITableView *)tableView;
- (NSString *)cellIdentifierForIndexPath:(NSIndexPath *)indexPath;

@end
