//
//  MTFileManagerInterface.h
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 15.10.15.
//  Copyright © 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTFileManagerCompletionHandlingConstants.h"
#import "MTFileManagerErrorHandlingConstants.h"

@protocol MTFileManagerInterface <NSObject>

- (void)downloadFileWithURL:(NSURL *)url
                 completion:(MTFileManagerDownloadFileCompletionBlock)completionBlock;
- (void)saveFileWithData:(NSData *)data
              completion:(MTFileManagerSaveFileCompletionBlock)completionBlock;
- (void)removeFileWithName:(NSString *)fileName
                completion:(MTFileManagerRemoveFileCompletionBlock)completionBlock;

@end
