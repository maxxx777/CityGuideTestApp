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
#import "MTImageManagerDelegate.h"
#import "MTImageManagerErrorHandlingConstants.h"

@interface MTImageManager ()

@property (nonatomic, strong) NSMutableDictionary *imageClients;
@property (nonatomic, strong) NSMutableDictionary *imageCache;
@property (nonatomic, strong) NSPointerArray *savePlaceOperations;

@end

@implementation MTImageManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        _imageClients = [NSMutableDictionary dictionary];
        _imageCache = [NSMutableDictionary dictionary];
        _savePlaceOperations = [NSPointerArray strongObjectsPointerArray];
        
        [self subscribeForNotifications];
    }
    return self;
}

- (void)dealloc
{
    [self unsubscribeFromNotifications];
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
            
            __weak MTImageManager *weakSelf = self;
            [self addImageToCacheForPlace:mappedPlace
                               completion:^(NSError *error, id place){
                                   if (!error) {
                                       [weakSelf notifyClientsWithPlace:mappedPlace
                                                                  error:error];
                                   }
                               }];
            
        } else {
    
            if (!isClientInQueue) {
                
                [self downloadFileWithURL:[NSURL URLWithString:mappedPlace.imageUrl]
                               completion:^(NSError *error, NSData *data){
                                   
                                   if (data) {
                                       
                                       [self saveFileWithData:data
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

- (void)downloadFileWithURL:(NSURL *)url
                 completion:(MTImageManagerDownloadFileCompletionBlock)completionBlock
{
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDownloadTask *downloadFileTask = [session downloadTaskWithURL:url
                                                            completionHandler:^(NSURL *location,
                                                                                NSURLResponse *response,
                                                                                NSError *error) {
                                                                NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
                                                                NSData *data;
                                                                if (httpResponse.statusCode == 200) {
                                                                    data = [NSData dataWithContentsOfURL:location];
                                                                } else {
                                                                    error = [NSError errorWithDomain:@"domain" code:httpResponse.statusCode userInfo:nil];
                                                                }
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
    [[MTOperationManager sharedManager].sharedOperationQueue addOperationWithBlock:^(){
        
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        df.dateFormat = @"yyyy-MM-dd-HH-mm-ss-SSS";
        
        NSString *fileName = [NSString stringWithFormat:@"IMG-%@.jpg", [df stringFromDate:[NSDate date]]];
        
        // Find system path
        NSString *filePath = [fileName mt_formatDocumentsPath];
        
        // Save as JPG
        NSError *error;
        [data writeToFile:filePath options:NSDataWritingAtomic error:&error];
        
        [[NSOperationQueue mainQueue] addOperationWithBlock: ^ {
            if (completionBlock) {
                completionBlock(error, fileName);
            }
        }];
    }];
}

- (void)removeFileWithName:(NSString *)fileName
                completion:(MTImageManagerRemoveFileCompletionBlock)completionBlock
{
    NSString *filePath = [fileName mt_formatDocumentsPath];
    NSError *error;
    [[NSFileManager defaultManager] removeItemAtPath:filePath error:&error];
    if (completionBlock) {
        completionBlock(error, fileName);
    }
}

- (UIImage *)imageWithImage:(UIImage *)image
               scaledToSize:(CGSize)newSize
{
    UIGraphicsBeginImageContext( newSize );
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

- (UIImage *)imageWithImage:(UIImage *)image
                   cropRect:(CGRect)cropRect
{
    UIImage *result;
    
    CGImageRef imageRef = CGImageCreateWithImageInRect(image.CGImage, cropRect);
    result = image;
    
    CGImageRelease(imageRef);
    
    return result;
}

#pragma mark - MTMergeObjectsOperationDelegate

- (void)onDidObjectMergeWithError:(NSError *)error
                           object:(id)object
             isOperationCancelled:(BOOL)isOperationCancelled
{
    if (!isOperationCancelled) {
        if (object) {
            
            MTMappedPlace *mappedPlace = (MTMappedPlace *)object;
            __weak MTImageManager *weakSelf = self;
            [self addImageToCacheForPlace:mappedPlace
                               completion:^(NSError *error, id place){
                                   if (!error) {
                                       [weakSelf notifyClientsWithPlace:mappedPlace
                                                                  error:error];
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
            clients = [NSPointerArray strongObjectsPointerArray];
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
        result = (self.imageClients)[clientId];
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

#pragma mark - Image Cache

- (void)addImageToCacheForPlace:(MTMappedPlace *)place
                     completion:(MTImageManagerCacheImageCompletionBlock)completion
{
    NSError *error;
    
    if (place) {
        if (![self.imageCache valueForKey:[self clientIdForPlace:place]]) {
            if (place.fileName) {
                NSString *filePath = [place.fileName mt_formatDocumentsPath];
                UIImage *image = [UIImage imageWithContentsOfFile:filePath];
                if (image) {
                    (self.imageCache)[[self clientIdForPlace:place]] = image;
                } else {
                    error = [NSError errorWithDomain:MTImageManagerErrorDomain
                                                code:MTImageManagerErrorAny
                                            userInfo:nil];
                }
            } else {
                error = [NSError errorWithDomain:MTImageManagerErrorDomain
                                            code:MTImageManagerErrorAny
                                        userInfo:nil];
            }
        }
    }
    completion(error, place);
}

- (UIImage *)imageFromCacheForPlace:(MTMappedPlace *)place
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

@end
