//
//  MTImageLoader.m
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 11.10.15.
//  Copyright © 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTImageManager.h"
#import "NSString+MTFormatting.h"
#import "MTMappedPlace.h"
#import "MTOperationManager.h"
#import "MTSavePlaceOperation.h"

@interface MTImageManager ()

@property (nonatomic, strong) NSMapTable *imageClients;
@property (nonatomic, strong) NSPointerArray *savePlaceOperations;

@end

@implementation MTImageManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        _imageClients = [[NSMapTable alloc] init];
        _savePlaceOperations = [NSPointerArray strongObjectsPointerArray];
        
    }
    return self;
}

+ (MTImageManager *)sharedManager
{
    static MTImageManager *sharedManager = nil;
    static dispatch_once_t isDispatched;
    
    dispatch_once(&isDispatched, ^
                  {
                      sharedManager = [[self alloc] init];
                  });
    
    return sharedManager;
}

#pragma mark - MTImageManagerInterface

- (void)fetchImageForPlace:(id)place
                completion:(MTImageManagerFetchImageCompletionBlock)completionBlock
{
    MTMappedPlace *mappedPlace = (MTMappedPlace *)place;
    
    if (mappedPlace.filePath) {
    
        completionBlock(nil, mappedPlace.filePath);
        
    } else {
        
        NSString *clientId = [NSString stringWithFormat:@"%@", mappedPlace.itemId];
        if (![self.imageClients objectForKey:clientId]) {
            
            [self.imageClients setObject:completionBlock
                                  forKey:clientId];
            
            [self downloadFileWithURL:[NSURL URLWithString:mappedPlace.imageUrl]
                           completion:^(NSError *error, NSData *data){
                
                               if (data) {
                                
                                   [self saveFileWithData:data
                                               completion:^(NSError *error, NSString *filePath){
                                       
                                                   if (filePath) {
                                                       
                                                       MTMappedPlace *placeWithFilePath = [[MTMappedPlace alloc]
                                                                                           initWithItemId:mappedPlace.itemId
                                                                                           itemName:mappedPlace.itemName
                                                                                           latitude:mappedPlace.latitude
                                                                                           longitude:mappedPlace.longitude
                                                                                           imageUrl:mappedPlace.imageUrl
                                                                                           filePath:filePath
                                                                                           placeDescription:mappedPlace.placeDescription
                                                                                           city:mappedPlace.city];
                                                       MTSavePlaceOperation *savePlaceOperation = [[MTSavePlaceOperation alloc] initWithPlace:placeWithFilePath mergeOperationDelegate:self];
                                                       [self.savePlaceOperations addPointer:(__bridge void * _Nullable)(savePlaceOperation)];
                                                       [[MTOperationManager sharedManager] queueOperation:savePlaceOperation];
                                                       
                                                   }
                                   }];
                               }
            }];
        }
    }
}

#pragma mark - Helper 

- (void)downloadFileWithURL:(NSURL *)url
                 completion:(MTImageManagerDownloadFileCompletionBlock)completionBlock
{
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDownloadTask *downloadFileTask = [session downloadTaskWithURL:url
                                                            completionHandler:^(NSURL *location,
                                                                                NSURLResponse *response,
                                                                                NSError *error) {
                                                                NSData *data = [NSData dataWithContentsOfURL:location];
                                                                dispatch_async(dispatch_get_main_queue(), ^{
                                                                    if (completionBlock) {
                                                                        completionBlock(error, data);
                                                                    }
                                                                });
               }];
    
    [downloadFileTask resume];
}

- (void)saveFileWithData:(NSData *)data
              completion:(MTImageManagerSaveFileCompletionBlock)completionBlock
{
    [[[MTOperationManager sharedManager] sharedOperationQueue] addOperationWithBlock:^(){
        
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        [df setDateFormat:@"yyyy-MM-dd-HH-mm-ss-SSS"];
        
        NSString *fileName = [NSString stringWithFormat:@"IMG-%@.jpg", [df stringFromDate:[NSDate date]]];
        
        // Find system path
        NSString *filePath = [fileName mt_formatDocumentsPath];
        
        // Save as JPG
        [data writeToFile:filePath atomically:YES];
        
        [[NSOperationQueue mainQueue] addOperationWithBlock: ^ {
            completionBlock(nil, filePath);
        }];
    }];
}

#pragma mark - MTMergeObjectsOperationDelegate

- (void)onDidObjectMergeWithError:(NSError *)error
                           object:(id)object
             isOperationCancelled:(BOOL)isOperationCancelled
{
    if (!isOperationCancelled) {
        if (object) {
            MTMappedPlace *place = (MTMappedPlace *)object;
            
            NSString *clientId = [NSString stringWithFormat:@"%@", place.itemId];
            if ([self.imageClients objectForKey:clientId]) {
             
                MTImageManagerFetchImageCompletionBlock completionBlock = [self.imageClients objectForKey:clientId];
                if (completionBlock) {
                    completionBlock(error, place.filePath);
                }                
            }
        }
    }
}

@end
