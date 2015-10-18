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
#import "MTSavePlaceOperation.h"
#import "MTImageManagerDelegate.h"
#import "MTImageManagerErrorHandlingConstants.h"
#import "MTImageCache.h"
#import "MTFileManager.h"
#import "MTOperationManager.h"

@interface MTImageManager ()
{
    MTFileManager *fileManager;
}
@property (nonatomic, strong) NSMutableDictionary *imageClients;
@property (nonatomic, strong) NSPointerArray *savePlaceOperations;

@end

@implementation MTImageManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        _imageClients = [NSMutableDictionary dictionary];
        _savePlaceOperations = [NSPointerArray weakObjectsPointerArray];
        
        fileManager = [[MTFileManager alloc] init];
    }
    return self;
}

+ (MTImageManager *)sharedManager
{
    static id sharedInstance;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

#pragma mark - MTImageManagerInterface

- (void)fetchImageForPlace:(id)place
                  delegate:(id<MTImageManagerDelegate>)delegate
{
    if (place) {
        
        MTMappedPlace *mappedPlace = (MTMappedPlace *)place;
    
        BOOL isClientInQueue = [self isClientInQueueWithPlace:mappedPlace];
        
        [self addClientWithPlace:mappedPlace
                        delegate:delegate];
        
        if (mappedPlace.fileName) {
            
            [[MTImageCache sharedCache] addImageToCacheForPlace:mappedPlace
                                                     completion:^(NSError *error, id place){
                                   if (!error) {
                                       [self notifyClientsWithPlace:mappedPlace
                                                              error:error];
                                   } else {
                                       //FIXME: notify clients about error
                                   }
                               }];
            
        } else {
    
            if (!isClientInQueue) {
                
                [fileManager downloadFileWithURL:[NSURL URLWithString:mappedPlace.imageUrl]
                                      completion:^(NSError *error, NSData *data){
                                   
                                   if (data) {
                                       
                                       [fileManager saveFileWithData:data
                                                          completion:^(NSError *error, NSString *fileName){
                                                       
                                                       if (fileName) {
                                                           
                                                           MTMappedPlace *placeWithFileName = [[MTMappedPlace alloc]
                                                                                               initWithItemId:mappedPlace.itemId
                                                                                               itemName:mappedPlace.itemName
                                                                                               latitude:mappedPlace.latitude
                                                                                               longitude:mappedPlace.longitude
                                                                                               imageUrl:mappedPlace.imageUrl
                                                                                               fileName:fileName
                                                                                               placeDescription:mappedPlace.placeDescription
                                                                                               city:mappedPlace.city];
                                                           MTSavePlaceOperation *savePlaceOperation = [[MTSavePlaceOperation alloc] initWithPlace:placeWithFileName mergeOperationDelegate:self];
                                                           [self.savePlaceOperations addPointer:(__bridge void * _Nullable)(savePlaceOperation)];
                                                           [[MTOperationManager sharedManager] queueOperation:savePlaceOperation];
                                                           
                                                       } else {
                                                           [self notifyClientsWithPlace:mappedPlace
                                                                                  error:error];
                                                       }
                                                   }];
                                   } else {
                                       [self notifyClientsWithPlace:mappedPlace
                                                              error:error];
                                   }
                               }];
            }
        }
    }
}

#pragma mark - MTMergeObjectsOperationDelegate

- (void)onDidObjectMergeWithError:(NSError *)error
                           object:(id)object
             isOperationCancelled:(BOOL)isOperationCancelled
{
    if (!isOperationCancelled) {
        if (object) {
            
            MTMappedPlace *mappedPlace = (MTMappedPlace *)object;
            [[MTImageCache sharedCache] addImageToCacheForPlace:mappedPlace
                                                     completion:^(NSError *error, id place){
                                   if (!error) {
                                       [self notifyClientsWithPlace:mappedPlace
                                                              error:error];
                                   } else {
                                       //FIXME: notify clients about error
                                   }
            }];
        }
    }
}

#pragma mark - Image Clients

- (void)notifyClientsWithPlace:(MTMappedPlace *)place
                         error:(NSError *)error
{
    if (place) {
        NSPointerArray *clients = [self clientsForPlace:place];
        if (clients.count > 0) {
            for (id<MTImageManagerDelegate> delegate in clients) {
                if (delegate) {
                    if (delegate && [delegate respondsToSelector:@selector(onDidFetchImageForPlace:error:)]) {
                        [delegate onDidFetchImageForPlace:place
                                                    error:error];
                    }
                }
            }
        }
        [self.imageClients removeObjectForKey:[self clientIdForPlace:place]];
    }
}

- (void)addClientWithPlace:(MTMappedPlace *)place
                  delegate:(id<MTImageManagerDelegate>)delegate
{
    if (place) {
        NSPointerArray *clients;
        
        if ([self clientsForPlace:place]) {
            clients = [self clientsForPlace:place];
        } else {
            clients = [NSPointerArray weakObjectsPointerArray];
        }
        if (delegate) {
            [clients addPointer:(__bridge void * _Nullable)(delegate)];
        }
        (self.imageClients)[[self clientIdForPlace:place]] = clients;
    }
}

- (NSPointerArray *)clientsForPlace:(MTMappedPlace *)place
{
    NSPointerArray *result;
    
    if ([self clientIdForPlace:place]) {
        result = (self.imageClients)[[self clientIdForPlace:place]];
    }
    
    return result;
}

- (BOOL)isClientInQueueWithPlace:(MTMappedPlace *)place
{
    BOOL result = NO;
    
    NSString *clientId = [self clientIdForPlace:place];
    if (clientId) {
        result = [self.imageClients objectForKey:clientId] != nil;
    }
    
    return result;
}

- (NSString *)clientIdForPlace:(MTMappedPlace *)place
{
    NSString *result;
    
    if (place) {
        result = [NSString stringWithFormat:@"%@", place.itemId];
    }
    
    return result;
}

@end
