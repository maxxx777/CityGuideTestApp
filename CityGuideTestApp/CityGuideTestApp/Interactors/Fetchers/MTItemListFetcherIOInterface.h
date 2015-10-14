//
//  MTItemListFetcherIOInterface.h
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 07.10.15.
//  Copyright (c) 2015 MAXIM TSVETKOV. All rights reserved.
//

@protocol MTItemListFetcherInputInterface <NSObject>

@property (NS_NONATOMIC_IOSONLY, readonly) NSUInteger countOfItems;
@property (NS_NONATOMIC_IOSONLY, readonly) NSUInteger numberOfSections;
- (NSUInteger)numberOfRowsInSection:(NSInteger)section;
@property (NS_NONATOMIC_IOSONLY, readonly, copy) NSArray *allItems;
@property (NS_NONATOMIC_IOSONLY, readonly, copy) NSArray *sectionIndexTitles;
- (NSString *)sectionIndexTitleForSectionName:(NSString *)sectionName;
- (NSString *)titleForHeaderInSection:(NSInteger)section;
- (id)objectAtIndexPath:(NSIndexPath *)indexPath;

@end

@protocol MTItemListFetcherOutputInterface <NSObject>

@end
