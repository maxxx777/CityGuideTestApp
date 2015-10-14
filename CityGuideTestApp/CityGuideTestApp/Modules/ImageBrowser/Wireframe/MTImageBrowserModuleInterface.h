//
//  MTImageBrowserModuleInterface.h
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 12.10.15.
//  Copyright © 2015 MAXIM TSVETKOV. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MTImageBrowserModuleInterface <NSObject>

- (void)showImageWithFileName:(NSString *)fileName
         navigationController:(UINavigationController *)navigationController;

@end
