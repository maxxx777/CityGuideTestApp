//
//  MTItemListChangeDetector.m
//  NotesTestApp
//
//  Created by MAXIM TSVETKOV on 30.09.15.
//  Copyright (c) 2015 Egar Technology Inc. All rights reserved.
//

#import "MTItemListChangeDetector.h"

@implementation MTItemListChangeDetector

- (void)onDidChangeContent
{
    for (id<MTItemListChangeDetectorOutputInterface> output in self.outputs) {
        if ([output respondsToSelector:@selector(onDidChangeItemList)]) {
            [output onDidChangeItemList];
        }
    }
}

@end
