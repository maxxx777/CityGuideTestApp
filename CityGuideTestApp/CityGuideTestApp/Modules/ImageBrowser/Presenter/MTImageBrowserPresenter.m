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

@property (nonatomic, strong) UIImage *image;
@property (nonatomic, weak) MTImageBrowserWireframe *wireframe;

@end

@implementation MTImageBrowserPresenter

- (instancetype)initWithImage:(UIImage *)image
                    wireframe:(MTImageBrowserWireframe *)wireframe
{
    self = [super init];
    if (self) {
        
        _image = image;
        _wireframe = wireframe;
        
    }
    return self;
}

- (UIViewController<MTImageBrowserViewInterface> *)userInterface
{
    NSAssert(_userInterface != nil, @"userInterface is equal to nil");
    return _userInterface;
}

#pragma mark - MTImageBrowserViewInterface

- (void)onDidLoadView
{
    [self.userInterface configureNavigationBarWithTitle:NSLocalizedString(@"Image", nil)];
    [self.userInterface configureImageWithImage:self.image];
}

@end
