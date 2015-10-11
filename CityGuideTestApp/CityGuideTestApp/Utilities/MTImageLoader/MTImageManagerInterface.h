//
//  MTImageLoaderInterface.h
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 11.10.15.
//  Copyright © 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTImageManagerConstants.h"

@protocol MTImageManagerInterface <NSObject>

- (void)loadImageFromURL:(NSURL *)url
              completion:(MTImageManagerCompletionBlock)completionBlock;
- (void)saveImageToFile:(UIImage *)image
             completion:(MTImageManagerCompletionBlock)completionBlock;

@end
