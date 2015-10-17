//
//  UIImageView+MTEditing.m
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 16.10.15.
//  Copyright © 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "UIImageView+MTEditing.h"

@implementation UIImageView (MTEditing)

- (void)mt_transformImageWithRotation:(double)rotation
{
    self.transform = CGAffineTransformMakeRotation(rotation);
}

@end
