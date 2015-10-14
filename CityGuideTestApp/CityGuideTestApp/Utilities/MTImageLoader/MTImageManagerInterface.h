//
//  MTImageLoaderInterface.h
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 11.10.15.
//  Copyright © 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTImageManagerConstants.h"

@protocol MTImageManagerInterface <NSObject>

- (void)fetchImageForPlace:(id)place
                completion:(MTImageManagerFetchImageCompletionBlock)completionBlock;
- (void)downloadFileWithURL:(NSURL *)url
                 completion:(MTImageManagerDownloadFileCompletionBlock)completionBlock;
- (void)saveFileWithData:(NSData *)data
              completion:(MTImageManagerSaveFileCompletionBlock)completionBlock;
- (UIImage *)imageWithImage:(UIImage *)image
               scaledToSize:(CGSize)newSize;
- (UIImage *)imageWithImage:(UIImage *)image
                   cropRect:(CGRect)cropRect;

@end
