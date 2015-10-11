//
//  MTItemListChangeDetector.h
//  NotesTestApp
//
//  Created by MAXIM TSVETKOV on 30.09.15.
//  Copyright (c) 2015 Egar Technology Inc. All rights reserved.
//

#import "MTRootInteractor.h"
#import "MTRootDataManagerDelegate.h"
#import "MTItemListChangeDetectorIOInterface.h"
#import "MTRootDataManagerInterface.h"

@interface MTItemListChangeDetector : MTRootInteractor
<
    MTRootDataManagerDelegate,
    MTItemListChangeDetectorInputInterface
>

@property (nonatomic, strong) id<MTRootDataManagerInterface>itemDataManager;

@end
