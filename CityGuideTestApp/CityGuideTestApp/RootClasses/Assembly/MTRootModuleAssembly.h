//
//  MTRootAssembly.h
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 09.11.15.
//  Copyright © 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "TyphoonAssembly.h"
#import "MTViewComponentsAssembly.h"
#import "MTDataComponentsAssembly.h"

@interface MTRootModuleAssembly : TyphoonAssembly

@property (nonatomic, strong, readonly) MTViewComponentsAssembly *viewComponentsAssembly;
@property (nonatomic, strong, readonly) MTDataComponentsAssembly *dataComponentsAssembly;

@end
