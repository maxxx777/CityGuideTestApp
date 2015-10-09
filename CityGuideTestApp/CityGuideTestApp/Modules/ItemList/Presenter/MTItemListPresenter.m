//
//  MTItemListPresenter.m
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 07.10.15.
//  Copyright (c) 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTItemListPresenter.h"
#import "MTItemListViewInterface.h"
#import "MTItemListWireframe.h"

@interface MTItemListPresenter ()

@property (nonatomic, weak) MTItemListWireframe *wireframe;

@end

@implementation MTItemListPresenter

- (instancetype)initWithWireframe:(MTItemListWireframe *)wireframe
{
    self = [super init];
    if (self) {
        
        _wireframe = wireframe;
        
    }
    return self;
}

#pragma mark - MTItemListPresenterInterface

- (void)configureView
{
    [self.userInterface configureNavigationBarWithTitle:NSLocalizedString(@"Cities", nil)];
}

@end
