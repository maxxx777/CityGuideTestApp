//
//  MTRootDataManagerErrorHandlingConstants.h
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 14.10.15.
//  Copyright © 2015 MAXIM TSVETKOV. All rights reserved.
//

static NSString *const MTRootDataManagerErrorDomain = @"MTRootDataManager.ErrorDomain";

//TODO: add more error types (e.g. merge data error)
typedef NS_ENUM(NSUInteger, MTRootDataManagerErrorType) {
    
    MTRootDataManagerErrorAny = 1
};
