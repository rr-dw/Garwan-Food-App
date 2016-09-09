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

#pragma mark -
#pragma mark Meal Categories + Food

+ (NSArray*)mealsFromArray:(NSArray*)meals
{
    NSMutableArray *results = [[NSMutableArray alloc] init];
    
    [meals enumerateObjectsUsingBlock:^(NSDictionary *meal, NSUInteger idx, BOOL * _Nonnull stop)
     {
         @autoreleasepool
         {
             NSNumber *n = [[meal valueForKey:@"servingSize"] valueForKey:@"price"];
             NSDecimalNumber *dbl = [NSDecimalNumber decimalNumberWithDecimal:[n decimalValue]];
             
             Food *food = [[Food alloc] initWithName:[meal valueForKey:@"name"]
                                               price:[dbl stringValue]
                                                size:[[meal valueForKey:@"servingSize"] valueForKey:@"size"]
                                              FoodId:nil
                                           andAddons:[meal valueForKey:@"addOnIds"]];
             
             [results addObject:food];
         }
     }];
    
    return results;
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

+ (NSArray*)mealsCategoriesFromJsonData:(NSData*)data
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

#pragma mark -
#pragma mark Addon Categories + Food

+ (NSArray*)addonsForCategory:(NSString*)name FromArray:(NSArray*)addons
{
    NSMutableArray *results = [[NSMutableArray alloc] init];
    
    [addons enumerateObjectsUsingBlock:^(NSDictionary *addon, NSUInteger idx, BOOL * _Nonnull stop)
     {
         @autoreleasepool
         {
             if ([name isEqualToString:[[addon valueForKey:@"category"] valueForKey:@"name"]])
             {
                 NSNumber *n = [[addon valueForKey:@"servingSize"] valueForKey:@"price"];
                 NSDecimalNumber *dbl = [NSDecimalNumber decimalNumberWithDecimal:[n decimalValue]];
                 
                 Food *food = [[Food alloc] initWithName:[addon valueForKey:@"name"]
                                                   price:[dbl stringValue]
                                                    size:[[addon valueForKey:@"servingSize"] valueForKey:@"size"]
                                                  FoodId:[addon valueForKey:@"id"]
                                               andAddons:[addon valueForKey:@"addOnIds"]];
                 
                 [results addObject:food];
             }
         }
     }];
    
    return results;
}

+ (NSArray*)addonsFromDictionary:(NSDictionary*)addonCategories and:(NSDictionary*)addons
{
    NSMutableArray *results = [[NSMutableArray alloc] init];
    
    NSArray *categoiresArr = [addonCategories valueForKey:@"addOnCategories"];
    
    [categoiresArr enumerateObjectsUsingBlock:^(NSDictionary *category, NSUInteger idx, BOOL * _Nonnull stop)
     {
         @autoreleasepool
         {
             FoodCategory *fc = [[FoodCategory alloc] initWithName:[category valueForKey:@"name"]
                                                          andMeals:[self addonsForCategory:[category valueForKey:@"name"] FromArray:[addons valueForKey:@"addOns"]]];
             
             [results addObject:fc];
         }
     }];
    
    return results;
}

+ (NSArray*)addonsCategoriesFromJsonData:(NSData*)cat withAddonsFronJsonData:(NSData*)add
{
    NSError* error = nil;
    NSDictionary* catDict = [NSJSONSerialization JSONObjectWithData:cat options:0 error:nil];
    NSDictionary* addDict = [NSJSONSerialization JSONObjectWithData:add options:0 error:nil];
    
    return [self addonsFromDictionary:catDict and:addDict];
}

@end
