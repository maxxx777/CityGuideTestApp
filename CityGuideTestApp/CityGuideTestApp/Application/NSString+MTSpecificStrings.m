//
//  NSString+ETSpecificStrings.m
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 07.10.15.
//  Copyright (c) 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "NSString+MTSpecificStrings.h"

@implementation NSString (MTSpecificStrings)

#pragma mark - MTSpecificStringsInterface

+ (NSString *)mt_appHostName
{
    return @"api.geonames.org";
}

+ (NSString *)mt_apiUserName
{
    return @"maxxx777";
}

+ (NSString *)mt_propertyNameForItemId
{
    return @"itemId";
}

@end
