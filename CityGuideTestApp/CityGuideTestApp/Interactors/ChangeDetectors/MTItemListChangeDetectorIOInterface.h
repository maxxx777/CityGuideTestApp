//
//  MTItemListChangeDetectorIOInterface.h
//  NotesTestApp
//
//  Created by MAXIM TSVETKOV on 30.09.15.
//  Copyright (c) 2015 Egar Technology Inc. All rights reserved.
//

@protocol MTItemListChangeDetectorInputInterface <NSObject>

@end

@protocol MTItemListChangeDetectorOutputInterface <NSObject>

@optional

- (void)onDidChangeItemList;

@end
