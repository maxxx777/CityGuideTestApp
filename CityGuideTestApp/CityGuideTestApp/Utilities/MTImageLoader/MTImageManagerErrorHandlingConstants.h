//
//  MTImageManagerErrorHandlingConstants.h
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 14.10.15.
//  Copyright © 2015 MAXIM TSVETKOV. All rights reserved.
//

static NSString *const MTImageManagerErrorDomain = @"MTImageManager.ErrorDomain";

//TODO: add more error types (e.g. http timeout)
typedef NS_ENUM(NSUInteger, MTImageManagerErrorType) {
    
    MTImageManagerErrorAny = 1
};
