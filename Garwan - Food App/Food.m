//
//  Food.m
//  Garwan - Food App
//
//  Created by Roman Roba on 08/09/16.
//  Copyright © 2016 Roman Roba. All rights reserved.
//

#import "Food.h"

@implementation Food

- (Food*)initWithName:(NSString*)name price:(NSString*)price size:(NSString*)size FoodId:(NSString*)foodId andHasAddons:(BOOL)hasAddons
{
    self = [super init];
    
    _name = name;
    _price = price;
    _size = size;
    _foodId = foodId;
    _hasAddons = hasAddons;
    
    return self;
}

@end
