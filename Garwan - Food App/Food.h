//
//  Food.h
//  Garwan - Food App
//
//  Created by Roman Roba on 08/09/16.
//  Copyright © 2016 Roman Roba. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Food : NSObject

@property (readonly) NSString *name;
@property (readonly) NSString *price;
@property (readonly) NSString *size;
@property (readonly) NSString *foodId;
@property (readonly) NSArray *addons;

- (Food*)initWithName:(NSString*)name price:(NSString*)price size:(NSString*)size FoodId:(NSString*)foodId andAddons:(NSArray*)hasAddons;

@end
