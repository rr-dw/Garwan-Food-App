//
//  DataRetriever.h
//  Garwan - Food App
//
//  Created by Roman Roba on 08/09/16.
//  Copyright © 2016 Roman Roba. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FoodCategory;

#define DATA_RETRIEVED @"DATA_RETRIEVED"

@interface DataRetriever : NSObject
{
    NSArray *categoriesAndFood;
    NSArray *addonsAndFood;
}

@property (atomic) int addonDataCategory;

- (void)loadData;
- (NSArray*) getAddonData;

+ (DataRetriever*)sharedInstance;

@end
