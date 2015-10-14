//
//  MTMergeObjectsOperationDelegate.h
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 07.10.15.
//  Copyright (c) 2015 MAXIM TSVETKOV. All rights reserved.
//

@protocol MTMergeObjectsOperationDelegate <NSObject>

@optional

- (void)onDidObjectsMergeWithError: (NSError *)error
              isOperationCancelled: (BOOL)isOperationCancelled;
- (void)onDidObjectMergeWithError: (NSError *)error
                           object: (id)object
             isOperationCancelled: (BOOL)isOperationCancelled;

@end
