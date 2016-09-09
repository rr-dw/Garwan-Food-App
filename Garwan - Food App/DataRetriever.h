//
//  DataRetriever.h
//  Garwan - Food App
//
//  Created by Roman Roba on 08/09/16.
//  Copyright © 2016 Roman Roba. All rights reserved.
//

#import <Foundation/Foundation.h>

#define DATA_RETRIEVED @"DATA_RETRIEVED"

@interface DataRetriever : NSObject
{
    NSArray *categoriesAndFood;
    NSArray *addonsAndFood;
}

- (void)loadData;

+ (DataRetriever*)sharedInstance;

@end
