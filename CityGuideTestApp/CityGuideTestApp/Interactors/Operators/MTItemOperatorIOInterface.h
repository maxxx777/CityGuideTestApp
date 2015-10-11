//
//  MTItemOperatorIOInterface.h
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 08.10.15.
//  Copyright (c) 2015 Egar Technology Inc. All rights reserved.
//

@protocol MTItemOperatorInputInterface <NSObject>

- (void)saveItem:(id)item;

@end

@protocol MTItemOperatorOutputInterface <NSObject>

@optional

- (void)onDidSaveItem;

@end
