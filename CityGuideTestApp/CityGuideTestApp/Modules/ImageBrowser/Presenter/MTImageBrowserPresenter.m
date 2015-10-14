//
//  MTImageBrowserPresenter.m
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 12.10.15.
//  Copyright © 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTImageBrowserPresenter.h"
#import "MTImageBrowserViewInterface.h"
#import "MTImageBrowserWireframe.h"

@interface MTImageBrowserPresenter ()

@property (nonatomic, strong) NSString *fileName;
@property (nonatomic, weak) MTImageBrowserWireframe *wireframe;

@end

@implementation MTImageBrowserPresenter

- (instancetype)initWithImageFileName:(NSString *)fileName
                            wireframe:(MTImageBrowserWireframe *)wireframe
{
    self = [super init];
    if (self) {
        
        _fileName = fileName;
        _wireframe = wireframe;
        
    }
    return self;
}

#pragma mark - MTImageBrowserViewInterface

- (void)onDidLoadView
{
    [self.userInterface configureNavigationBarWithTitle:NSLocalizedString(@"Image", nil)];
    [self.userInterface configureImageWithFileName:self.fileName];
}

@end
