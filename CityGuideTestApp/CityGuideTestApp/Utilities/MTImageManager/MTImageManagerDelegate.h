//
//  MTImageManagerDelegate.h
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 14.10.15.
//  Copyright © 2015 MAXIM TSVETKOV. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MTImageManagerDelegate <NSObject>

- (void)onDidFetchImageForPlace:(id)place
                          error:(NSError *)error;

@end
