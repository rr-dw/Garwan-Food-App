//
//  FoodCategory.h
//  Garwan - Food App
//
//  Created by Roman Roba on 08/09/16.
//  Copyright © 2016 Roman Roba. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FoodCategory : NSObject

@property (readonly) NSString *name;
@property (readonly) NSArray *meals;

+ (NSArray*)categoriesFromJsonData:(NSData*)data;

@end
