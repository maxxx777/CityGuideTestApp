//
//  MTItemWebService.m
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 07.10.15.
//  Copyright (c) 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTItemWebService.h"
#import "NSString+MTSpecificStrings.h"
#import "MTFileManager.h"

@interface MTItemWebService ()
{
    MTFileManager *fileManager;
}

@end

@implementation MTItemWebService

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        fileManager = [[MTFileManager alloc] init];
        
    }
    return self;
}

#pragma mark - MTItemWebServiceInterface

- (void)fetchItemListWithCompletion:(MTRootServiceRequestCompletionBlock)completion
{
    [fileManager readJSONFromFileWithName:@"places_25_06"
                               completion:^(NSError *error, NSString *fileName, NSDictionary *rawData){
                                   
                                   if (rawData) {
                                       
                                       dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
                                           
                                           id result;
                                           if ([self.parser respondsToSelector:@selector(parseItemListFromRawData:)]) {
                                               result = [self.parser parseItemListFromRawData:rawData];
                                           }
                                           
                                           dispatch_sync(dispatch_get_main_queue(), ^{
                                               if (completion) {
                                                   completion(result, error);
                                               }
                                           });
                                           
                                       });
                                       
                                   } else {
                                       
                                       if (completion) {
                                           completion(nil, error);
                                       }
                                       
                                   }
    }];
}

@end
