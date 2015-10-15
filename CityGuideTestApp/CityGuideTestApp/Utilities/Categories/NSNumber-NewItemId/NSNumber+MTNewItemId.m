//
//  NSNumber+MTNewItemId.m
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 11.10.15.
//  Copyright © 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "NSNumber+MTNewItemId.h"
#include <stdlib.h>

@implementation NSNumber (MTNewItemId)

+ (NSNumber *)mt_newItemId
{
    long r = arc4random_uniform(999999);
    
    return [NSNumber numberWithUnsignedLong:r];
}

@end
