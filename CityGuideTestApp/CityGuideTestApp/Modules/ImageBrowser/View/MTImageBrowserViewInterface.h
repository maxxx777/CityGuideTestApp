//
//  MTImageBrowserViewInterface.h
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 12.10.15.
//  Copyright © 2015 MAXIM TSVETKOV. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MTImageBrowserViewInterface <NSObject>

- (void)configureNavigationBarWithTitle: (NSString *)title;
- (void)configureImage:(UIImage *)image;

@end
