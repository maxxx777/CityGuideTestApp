//
//  MTFileManager.m
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 15.10.15.
//  Copyright © 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTFileManager.h"
#import "MTOperationManager.h"
#import "NSString+MTFormatting.h"

@implementation MTFileManager

- (void)downloadFileWithURL:(NSURL *)url
                 completion:(MTFileManagerDownloadFileCompletionBlock)completionBlock
{
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDownloadTask *downloadFileTask = [session downloadTaskWithURL:url
                                                            completionHandler:^(NSURL *location,
                                                                                NSURLResponse *response,
                                                                                NSError *error) {
                                                                NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
                                                                NSData *data;
                                                                if (httpResponse.statusCode == 200) {
                                                                    data = [NSData dataWithContentsOfURL:location];
                                                                } else {
                                                                    error = [NSError errorWithDomain:MTFileManagerErrorDomain code:MTFileManagerErrorAny userInfo:nil];
                                                                }
                                                                dispatch_async(dispatch_get_main_queue(), ^{
                                                                    if (completionBlock) {
                                                                        completionBlock(error, data);
                                                                    }
                                                                });
                                                            }];
    
    [downloadFileTask resume];
}

- (void)readJSONFromFileWithName:(NSString *)fileName
                      completion:(MTFileManagerReadJSONCompletionBlock)completionBlock
{
    [[MTOperationManager sharedManager] queueOperationWithBlock:^(){
       
        NSError *error;
        NSString *filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"json"];
        NSData *data = [NSData dataWithContentsOfFile:filePath];
        NSDictionary *rawData = [NSJSONSerialization JSONObjectWithData:data
                                                                options:kNilOptions
                                                                  error:&error];
        [[NSOperationQueue mainQueue] addOperationWithBlock: ^ {
            if (completionBlock) {
                completionBlock(error, fileName, rawData);
            }
        }];
    }];
}

- (void)saveFileWithData:(NSData *)data
              completion:(MTFileManagerSaveFileCompletionBlock)completionBlock
{
    [[MTOperationManager sharedManager] queueOperationWithBlock:^(){
        
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        df.dateFormat = @"yyyy-MM-dd-HH-mm-ss-SSS";
        
        NSString *fileName = [NSString stringWithFormat:@"IMG-%@.jpg", [df stringFromDate:[NSDate date]]];
        
        // Find system path
        NSString *filePath = [fileName mt_formatDocumentsPath];
        
        // Save as JPG
        NSError *error;
        [data writeToFile:filePath options:NSDataWritingAtomic error:&error];
        
        [[NSOperationQueue mainQueue] addOperationWithBlock: ^ {
            if (completionBlock) {
                completionBlock(error, fileName);
            }
        }];
    }];
}

- (void)removeFileWithName:(NSString *)fileName
                completion:(MTFileManagerRemoveFileCompletionBlock)completionBlock
{
    NSString *filePath = [fileName mt_formatDocumentsPath];
    NSError *error;
    [[NSFileManager defaultManager] removeItemAtPath:filePath error:&error];
    if (completionBlock) {
        completionBlock(error, fileName);
    }
}

@end
