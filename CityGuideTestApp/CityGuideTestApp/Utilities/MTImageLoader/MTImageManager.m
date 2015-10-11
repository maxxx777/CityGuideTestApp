//
//  MTImageLoader.m
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 11.10.15.
//  Copyright © 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTImageManager.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "NSString+MTFormatting.h"

@implementation MTImageManager

#pragma mark - MTImageManagerInterface

- (void)loadImageFromURL:(NSURL *)url
              completion:(MTImageManagerCompletionBlock)completionBlock
{
    [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:url
                                                          options:SDWebImageDownloaderUseNSURLCache
                                                         progress:nil
                                                        completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished){
                                                            if (finished) {
                                                                
                                                                dispatch_sync(dispatch_get_main_queue(), ^{
                                                                    if (completionBlock) {
                                                                        completionBlock(nil, image, nil);
                                                                    }
                                                                });
                                                                
                                                            }
    }];
}

- (void)saveImageToFile:(UIImage *)image
             completion:(MTImageManagerCompletionBlock)completionBlock
{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd-HH-mm-ss"];
    
    NSString *imageName = [NSString stringWithFormat:@"IMG-%@.jpg", [df stringFromDate:[NSDate date]]];
    
    // Find system path
    NSString *imagePath = [imageName mt_formatDocumentsPath];
    
    // Save as JPG
    NSData *jpgData = UIImageJPEGRepresentation(image, 0.9f);
    [jpgData writeToFile:imagePath atomically:YES];
    
    if (completionBlock) {
        completionBlock(nil, image, imagePath);
    }
}

@end
