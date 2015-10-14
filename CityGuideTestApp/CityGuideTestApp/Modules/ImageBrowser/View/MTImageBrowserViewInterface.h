//
//  MTImageBrowserViewInterface.h
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 12.10.15.
//  Copyright © 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTRootViewInterface.h"

@protocol MTImageBrowserViewInterface <NSObject, MTRootViewInterface>

- (void)configureImageWithImage:(UIImage * _Nonnull)image;

@end
