//
//  MTItemListFetcherIOInterface.h
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 07.10.15.
//  Copyright (c) 2015 MAXIM TSVETKOV. All rights reserved.
//

@protocol MTItemListFetcherInputInterface <NSObject>

@optional

- (NSUInteger)countOfItems;
- (NSUInteger)numberOfSections;
- (NSUInteger)numberOfRowsInSection:(NSInteger)section;
- (NSArray *)allItems;
- (NSArray *)sectionIndexTitles;
- (NSString *)sectionIndexTitleForSectionName:(NSString *)sectionName;
- (NSString *)titleForHeaderInSection:(NSInteger)section;
- (id)objectAtIndexPath:(NSIndexPath *)indexPath;
- (NSIndexPath *)indexPathForObjectWithItemId:(NSNumber *)itemId;

@end

@protocol MTItemListFetcherOutputInterface <NSObject>

@end
