//
//  MTWebServiceParserInterface.h
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 07.10.15.
//  Copyright (c) 2015 MAXIM TSVETKOV. All rights reserved.
//

@protocol MTWebServiceParserInterface <NSObject>

@optional

- (id _Nullable)parseItemListFromRawData:(id _Nonnull)rawData;

@end
