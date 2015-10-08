//
//  NSNumber+ETNewItemId.m
//  NotesTestApp
//
//  Created by MAXIM TSVETKOV on 30.09.15.
//  Copyright (c) 2015 Egar Technology Inc. All rights reserved.
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
