//
//  MTRootWebService.m
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 07.10.15.
//  Copyright (c) 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTRootWebService.h"
#import "MTWebServiceParser.h"

@interface MTRootWebService ()

@property (nonatomic, strong) id<MTWebServiceParserInterface>parser;

@end

@implementation MTRootWebService

- (void)dealloc
{
    DLog(@"%@ deallocated: %p", NSStringFromClass([self class]), self);
}

- (instancetype)initWithParser:(id<MTWebServiceParserInterface>)parser
{
    self = [super init];
    if (self) {
        
        _parser = parser;
        
    }
    return self;
}

- (instancetype)init
{
    MTWebServiceParser *parser = [[MTWebServiceParser alloc] init];
    return [self initWithParser:parser];
}

@end
