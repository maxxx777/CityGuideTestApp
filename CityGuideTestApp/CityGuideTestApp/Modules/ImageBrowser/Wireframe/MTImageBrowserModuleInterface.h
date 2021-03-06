//
//  MTImageBrowserModuleInterface.h
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 12.10.15.
//  Copyright © 2015 MAXIM TSVETKOV. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MTImageBrowserModuleInterface <NSObject>

- (void)showImage:(UIImage * _Nonnull)image navigationController:(UINavigationController * _Nonnull)navigationController;

@end
