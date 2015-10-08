//
//  MTSpecificColorsInterface.h
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 07.10.15.
//  Copyright (c) 2015 MAXIM TSVETKOV. All rights reserved.
//

@protocol MTSpecificColorsInterface <NSObject>

+ (UIColor *)mt_tableViewTextColor;
+ (UIColor *)mt_tableViewBackgroundColor;
+ (UIColor *)mt_tableViewFooterTextColor;
+ (UIColor *)mt_tableViewSectionIndexColor;

@end
