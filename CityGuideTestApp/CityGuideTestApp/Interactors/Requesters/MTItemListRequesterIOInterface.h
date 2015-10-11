//
//  MTItemListRequesterIOInterface.h
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 07.10.15.
//  Copyright (c) 2015 MAXIM TSVETKOV. All rights reserved.
//

@protocol MTItemListRequesterInputInterface <NSObject>

@optional

- (void)fetchAllItems;
- (void)fetchItemsWithin1Mile;
- (void)fetchItemsWithin10Mile;
- (void)fetchItemsWithin100Mile;
- (void)cancelActions;

@end

@protocol MTItemListRequesterOutputInterface <NSObject>

- (void)onDidFetchItemsWithError:(NSError *)error;

@end
