//
//  MTImageLoaderInterface.h
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 11.10.15.
//  Copyright © 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTImageManagerCompletionHandlingConstants.h"

@protocol MTImageManagerDelegate;

@class MTMappedPlace;

@protocol MTImageManagerInterface <NSObject>

- (void)fetchImageForPlace:(id)place
                  delegate:(id<MTImageManagerDelegate>)delegate;
- (void)downloadFileWithURL:(NSURL *)url
                 completion:(MTImageManagerDownloadFileCompletionBlock)completionBlock;
- (void)saveFileWithData:(NSData *)data
              completion:(MTImageManagerSaveFileCompletionBlock)completionBlock;
- (void)removeFileWithName:(NSString *)fileName
                completion:(MTImageManagerRemoveFileCompletionBlock)completionBlock;
- (UIImage *)imageWithImage:(UIImage *)image
               scaledToSize:(CGSize)newSize;
- (UIImage *)imageWithImage:(UIImage *)image
                   cropRect:(CGRect)cropRect;
- (UIImage *)imageFromCacheForPlace:(MTMappedPlace *)place;

@end
