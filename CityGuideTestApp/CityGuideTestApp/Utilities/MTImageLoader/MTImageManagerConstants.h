//
//  MTImageLoaderConstants.h
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 11.10.15.
//  Copyright © 2015 MAXIM TSVETKOV. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^MTImageManagerFetchImageCompletionBlock)(NSError *error, NSString *fileName);
typedef void (^MTImageManagerDownloadFileCompletionBlock)(NSError *error, NSData *data);
typedef void (^MTImageManagerSaveFileCompletionBlock)(NSError *error, NSString *fileName);
typedef void (^MTImageManagerRemoveFileCompletionBlock)(NSError *error, NSString *fileName);
typedef void (^MTImageManagerCacheImageCompletionBlock)(NSError *error, id place);

static NSString *const MTImageManagerErrorDomain = @"MTImageManager.ErrorDomain";

typedef NS_ENUM(NSUInteger, MTImageManagerErrorType) {
    
    MTImageManagerErrorNoImage = 1
};


