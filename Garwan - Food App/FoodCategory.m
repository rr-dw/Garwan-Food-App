//
//  FoodCategory.m
//  Garwan - Food App
//
//  Created by Roman Roba on 08/09/16.
//  Copyright © 2016 Roman Roba. All rights reserved.
//

#import "FoodCategory.h"
#import "Food.h"

@implementation FoodCategory

- (FoodCategory*) initWithName:(NSString*)name andMeals:(NSArray*)meals
{
    self = [super init];
    
    _name = name;
    _meals = meals;
    
    return self;
}

+ (NSArray*)categoriesFromDictionary:(NSDictionary*)mealCategories
{
    NSMutableArray *results = [[NSMutableArray alloc] init];
    
    NSArray *categoiresArr = [mealCategories valueForKey:@"mealCategories"];
    
    [categoiresArr enumerateObjectsUsingBlock:^(NSDictionary *category, NSUInteger idx, BOOL * _Nonnull stop)
    {
        @autoreleasepool
        {
            FoodCategory *fc = [[FoodCategory alloc] initWithName:[category valueForKey:@"name"]
                                                         andMeals:[self mealsFromArray:[category valueForKey:@"meals"]]];
            
            [results addObject:fc];
        }
    }];
    
    return results;
}

+ (NSArray*)mealsFromArray:(NSArray*)meals
{
    NSMutableArray *results = [[NSMutableArray alloc] init];
    
    [meals enumerateObjectsUsingBlock:^(NSDictionary *meal, NSUInteger idx, BOOL * _Nonnull stop)
    {
        Food *food = [[Food alloc] initWithName:[meal valueForKey:@"name"]
                                          price:[[meal valueForKey:@"servingSize"] valueForKey:@"price"]
                                           size:[[meal valueForKey:@"servingSize"] valueForKey:@"size"]
                                         FoodId:[meal valueForKey:@"id"]
                                   andHasAddons:((NSArray*)[meal valueForKey:@"addOnIds"]).count > 0 ? YES : NO ];
        
        [results addObject:food];
    }];
    
    return results;
}

+ (NSArray*)categoriesFromJsonData:(NSData*)data
{
    NSError* error = nil;
    NSDictionary* dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    
    if (error)
    {
        //TODO: handle error
        return nil;
    }
    
    return [self categoriesFromDictionary:dict];
}

@end