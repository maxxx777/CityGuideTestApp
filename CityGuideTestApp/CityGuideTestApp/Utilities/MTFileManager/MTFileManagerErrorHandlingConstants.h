//
//  MTFileManagerErrorHandlingConstants.h
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 15.10.15.
//  Copyright © 2015 MAXIM TSVETKOV. All rights reserved.
//

static NSString *const MTFileManagerErrorDomain = @"MTFileManager.ErrorDomain";

//FIXME: add more error types (for each situation)
typedef NS_ENUM(NSUInteger, MTFileManagerErrorType) {
    
    MTFileManagerErrorAny = 1
};
