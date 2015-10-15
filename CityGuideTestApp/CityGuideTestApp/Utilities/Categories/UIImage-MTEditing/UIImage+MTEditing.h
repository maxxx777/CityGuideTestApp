//
//  UIImageView+MTEditing.h
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 15.10.15.
//  Copyright © 2015 MAXIM TSVETKOV. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (MTEditing)

- (UIImage *)mt_resizeToSize:(CGSize)newSize;
- (UIImage *)mt_cropToRect:(CGRect)cropRect;

@end
