//
//  MTImageCache.m
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 15.10.15.
//  Copyright © 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTImageCache.h"
#import "NSString+MTFormatting.h"
#import "MTMappedPlace.h"

@interface MTImageCache ()

@property (nonatomic, strong) NSMutableDictionary *imageCache;

@end

@implementation MTImageCache

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        _imageCache = [NSMutableDictionary dictionary];
        
        [self subscribeForNotifications];
    }
    return self;
}

- (void)dealloc
{
    [self unsubscribeFromNotifications];
}

+ (MTImageCache *)sharedCache
{
    static id sharedInstance;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

#pragma mark - MTImageCacheInterface

- (void)addImageToCacheForPlace:(id)place
                     completion:(MTImageCacheCompletionBlock)completion
{
    NSError *error;
    
    if (place) {
        if (![self.imageCache valueForKey:[self clientIdForPlace:place]]) {
            MTMappedPlace *mappedPlace = (MTMappedPlace *)place;
            if (mappedPlace.fileName) {
                NSString *filePath = [mappedPlace.fileName mt_formatDocumentsPath];
                UIImage *image = [UIImage imageWithContentsOfFile:filePath];
                if (image) {
                    (self.imageCache)[[self clientIdForPlace:mappedPlace]] = image;
                } else {
                    error = [NSError errorWithDomain:MTImageCacheErrorDomain
                                                code:MTImageCacheErrorAny
                                            userInfo:nil];
                }
            } else {
                error = [NSError errorWithDomain:MTImageCacheErrorDomain
                                            code:MTImageCacheErrorAny
                                        userInfo:nil];
            }
        }
    }
    completion(error, place);
}

- (UIImage *)imageFromCacheForPlace:(id)place
{
    UIImage *result;
    
    if (place) {
        result = (self.imageCache)[[self clientIdForPlace:place]];
    }
    
    return result;
}

- (void)clearImageCache
{
    self.imageCache = [NSMutableDictionary dictionary];
}

#pragma mark - Notifications

- (void)subscribeForNotifications {
    
    [self unsubscribeFromNotifications];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onDidReceiveMemoryWarning)
                                                 name:UIApplicationDidReceiveMemoryWarningNotification
                                               object:nil];
}

- (void)unsubscribeFromNotifications {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIApplicationDidReceiveMemoryWarningNotification
                                                  object:nil];
}

- (void)onDidReceiveMemoryWarning
{
    [self clearImageCache];
}

#pragma mark - Helper

- (NSString *)clientIdForPlace:(id)place
{
    NSString *result;
    
    if (place) {
        MTMappedPlace *mappedPlace = (MTMappedPlace *)place;
        result = [NSString stringWithFormat:@"%@", mappedPlace.itemId];
    }
    
    return result;
}

@end
