//
//  MTRootWebService.h
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 07.10.15.
//  Copyright (c) 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTWebServiceParserInterface.h"
#import "MTRootServiceConstants.h"

@interface MTRootWebService : NSObject

@property (nonatomic, strong, readonly) id<MTWebServiceParserInterface>parser;

- (instancetype)initWithParser:(id<MTWebServiceParserInterface>)parser NS_DESIGNATED_INITIALIZER;

@end
