//
//  MTImageLoaderInterface.h
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 11.10.15.
//  Copyright © 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTImageManagerCompletionHandlingConstants.h"

@protocol MTImageManagerDelegate;

@protocol MTImageManagerInterface <NSObject>

- (void)fetchImageForPlace:(id)place
                  delegate:(id<MTImageManagerDelegate>)delegate;

@end
