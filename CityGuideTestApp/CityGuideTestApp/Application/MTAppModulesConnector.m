//
//  MTAppModulesConnector.h
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 07.10.15.
//  Copyright (c) 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTAppModulesConnector.h"
#import "MTItemListWireframe.h"
#import "MTItemDetailWireframe.h"

@interface MTAppModulesConnector ()

@property (nonatomic, strong) UIWindow *window;
@property (nonatomic, strong) MTItemListWireframe *itemListModule;

@end

@implementation MTAppModulesConnector

- (instancetype)initWithWindow:(UIWindow *)window
{
    self = [super init];
    if (self) {
        
        _window = window;
    
    }
    return self;
}

#pragma mark - MTAppModulesConnectorInterface

- (void)configureDependencies
{
    _itemListModule = [[MTItemListWireframe alloc] init];
    MTItemDetailWireframe *itemDetailModule = [[MTItemDetailWireframe alloc] init];
    
    self.itemListModule.itemDetailModule = itemDetailModule;
}

- (void)showMainScreen
{
    [self.itemListModule showItemListViewInWindow:self.window];
}

@end
