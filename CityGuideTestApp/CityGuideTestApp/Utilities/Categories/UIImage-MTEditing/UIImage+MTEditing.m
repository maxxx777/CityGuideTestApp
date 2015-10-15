//
//  UIImageView+MTEditing.m
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 15.10.15.
//  Copyright © 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "UIImage+MTEditing.h"

@implementation UIImage (MTEditing)

- (UIImage *)mt_resizeToSize:(CGSize)newSize
{
    UIGraphicsBeginImageContext( newSize );
    [self drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

- (UIImage *)mt_cropToRect:(CGRect)cropRect
{
    UIImage *result;
    
    CGImageRef imageRef = CGImageCreateWithImageInRect(self.CGImage, cropRect);
    result = self;
    
    CGImageRelease(imageRef);
    
    return result;
}

@end
