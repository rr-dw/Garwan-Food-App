//
//  DataRetriever.m
//  Garwan - Food App
//
//  Created by Roman Roba on 08/09/16.
//  Copyright © 2016 Roman Roba. All rights reserved.
//

#import "DataRetriever.h"
#import "FoodCategory.h"

@implementation DataRetriever

#pragma mark -
#pragma mark Retrieving Data from Internet

- (NSArray*) getAddonData
{
    return @[addonsAndFood[self.addonDataCategory]];
}

- (void)loadData
{
    dispatch_group_t gcdGroup = dispatch_group_create();
    
    dispatch_group_async(gcdGroup, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),
    ^{
        [self loadMealCategory];
    });
    
    __block NSData *cat;
    dispatch_group_async(gcdGroup, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),
    ^{
        cat = [self loadAddonCategory];
    });
    
    __block NSData *add;
    dispatch_group_async(gcdGroup, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),
    ^{
        add = [self loadAddons];
    });
    
    dispatch_group_notify(gcdGroup, dispatch_get_main_queue(),
    ^{
        addonsAndFood = [FoodCategory addonsCategoriesFromJsonData:cat withAddonsFronJsonData:add];
        [[NSNotificationCenter defaultCenter] postNotificationName:DATA_RETRIEVED object:nil userInfo:[NSDictionary dictionaryWithObject:categoriesAndFood forKey:DATA_RETRIEVED]];
    });
}

- (void)loadMealCategory
{
    NSURL *url = [NSURL URLWithString:@"https://papagaj-breweria.herokuapp.com/api/v1/menu/54ca39f401731406200082df/meal/category"];
    
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"GET"];
    [self setAutorizationIntoHeader:request];
    
    NSHTTPURLResponse* resp = nil;
    NSError* error = nil;
    NSData* respData = [NSURLConnection sendSynchronousRequest:request returningResponse:&resp error:&error];
    
    if (error)
    {
        NSLog(@"Error to load MealCategories: %@", error);
        return;
    }
    
    if (resp.statusCode == 200)
    {
        categoriesAndFood = [FoodCategory mealsCategoriesFromJsonData:respData];
    }
    else
    {
        NSLog(@"Failed to load Meal Caregories");
    }
}

- (NSData*)loadAddonCategory
{
    NSURL *url = [NSURL URLWithString:@"https://papagaj-breweria.herokuapp.com/api/v1/menu/54ca39f401731406200082df/addon/category"];
    
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"GET"];
    [self setAutorizationIntoHeader:request];
    
    NSHTTPURLResponse* resp = nil;
    NSError* error = nil;
    NSData* respData = [NSURLConnection sendSynchronousRequest:request returningResponse:&resp error:&error];
    
    if (error)
    {
        NSLog(@"Error to load Addon Categories: %@", error);
        return nil;
    }
    
    if (resp.statusCode == 200)
    {
        return respData;
    }
    else
    {
        NSLog(@"Failed to load Addon Caregories");
        return nil;
    }
}

- (NSData*)loadAddons
{
    NSURL *url = [NSURL URLWithString:@"https://papagaj-breweria.herokuapp.com/api/v1/menu/54ca39f401731406200082df/addon"];
    
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"GET"];
    [self setAutorizationIntoHeader:request];
    
    NSHTTPURLResponse* resp = nil;
    NSError* error = nil;
    NSData* respData = [NSURLConnection sendSynchronousRequest:request returningResponse:&resp error:&error];
    
    if (error)
    {
        NSLog(@"Error to load Addons: %@", error);
        return nil;
    }
    
    if (resp.statusCode == 200)
    {
        return respData;
    }
    else
    {
        NSLog(@"Failed to load Addons");
        return nil;
    }
}

- (void)setAutorizationIntoHeader:(NSMutableURLRequest*)request
{
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json, text/json" forHTTPHeaderField:@"Accept"];
}

#pragma mark -
#pragma mark Retriever Itself

static DataRetriever *dataRetriever;

+ (DataRetriever*)sharedInstance
{
    if (!dataRetriever) dataRetriever = [[DataRetriever alloc] init];
    
    return dataRetriever;
}

@end
