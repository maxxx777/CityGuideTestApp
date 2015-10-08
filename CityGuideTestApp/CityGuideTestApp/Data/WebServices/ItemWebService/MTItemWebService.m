//
//  MTItemWebService.m
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 07.10.15.
//  Copyright (c) 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTItemWebService.h"
#import "NSString+MTSpecificStrings.h"

@implementation MTItemWebService

#pragma mark - MTItemWebServiceInterface

- (void)fetchItemListWithCompletion:(MTRootServiceRequestCompletionBlock)completion
{
    NSError *error = nil;
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"places_25_06" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    NSDictionary *rawData = [NSJSONSerialization JSONObjectWithData:data
                                                            options:kNilOptions
                                                              error:&error];
    
    if (rawData) {
        
        id result = [self.parser parseItemListFromRawData:rawData];
        
        completion(result, error);
        
    } else {
        
        completion(nil, error);
        
    }
}

@end
