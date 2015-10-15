//
//  UIImageView+MTActivityAnimation.m
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 11.10.15.
//  Copyright © 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "UIImageView+MTActivityAnimation.h"

@implementation UIImageView (MTActivityAnimation)

- (void)mt_startActivityAnimation
{
    __block UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    activityIndicator.hidesWhenStopped = YES;
    
    [self addSubview:activityIndicator];
    [activityIndicator startAnimating];
    
    [activityIndicator setTranslatesAutoresizingMaskIntoConstraints:NO];
    NSLayoutConstraint *heightConstraint =
    [NSLayoutConstraint constraintWithItem:self
                                 attribute:NSLayoutAttributeCenterX
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:activityIndicator
                                 attribute:NSLayoutAttributeCenterX
                                multiplier:1.0
                                  constant:0];
    [self addConstraint:heightConstraint];
    
    NSLayoutConstraint *widthConstraint =
    [NSLayoutConstraint constraintWithItem:self
                                 attribute:NSLayoutAttributeCenterY
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:activityIndicator
                                 attribute:NSLayoutAttributeCenterY
                                multiplier:1.0
                                  constant:0];
    [self addConstraint:widthConstraint];
}

- (void)mt_stopActivityAnimation
{
    for (UIView *subView in self.subviews) {
        if ([subView isKindOfClass:[UIActivityIndicatorView class]]) {
            [subView removeFromSuperview];
        }
    }
}

@end
