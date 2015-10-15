//
//  MTFileManagerCompletionHandlingConstants.h
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 15.10.15.
//  Copyright © 2015 MAXIM TSVETKOV. All rights reserved.
//

typedef void (^MTFileManagerDownloadFileCompletionBlock)(NSError *error, NSData *data);
typedef void (^MTFileManagerSaveFileCompletionBlock)(NSError *error, NSString *fileName);
typedef void (^MTFileManagerRemoveFileCompletionBlock)(NSError *error, NSString *fileName);
