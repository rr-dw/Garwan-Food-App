//
//  Food.m
//  Garwan - Food App
//
//  Created by Roman Roba on 08/09/16.
//  Copyright © 2016 Roman Roba. All rights reserved.
//

#import "Food.h"

@implementation Food

- (Food*)initWithName:(NSString*)name price:(NSString*)price size:(NSString*)size FoodId:(NSString*)foodId andAddons:(NSArray*)addons
{
    self = [super init];
    
    _name = name;
    _price = price;
    _size = size;
    _foodId = foodId;
    _addons = addons;
    
    return self;
}

@end
