//
//  MTMergeObjectsOperationDelegate.h
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 07.10.15.
//  Copyright (c) 2015 MAXIM TSVETKOV. All rights reserved.
//

@protocol MTMergeObjectsOperationDelegate <NSObject>

@optional

- (void)onDidObjectsMergeWithError: (NSError * _Nullable)error
              isOperationCancelled: (BOOL)isOperationCancelled;
- (void)onDidObjectMergeWithError: (NSError * _Nullable)error
                           object: (id _Nonnull)object
             isOperationCancelled: (BOOL)isOperationCancelled;

@end
