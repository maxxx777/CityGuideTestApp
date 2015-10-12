//
//  MTImageLoaderConstants.h
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 11.10.15.
//  Copyright © 2015 MAXIM TSVETKOV. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^MTImageManagerFetchImageCompletionBlock)(NSError *error, NSString *filePath);
typedef void (^MTImageManagerDownloadFileCompletionBlock)(NSError *error, NSData *data);
typedef void (^MTImageManagerSaveFileCompletionBlock)(NSError *error, NSString *filePath);
