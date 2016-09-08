//
//  FoodDetailTableViewCell.h
//  Garwan - Food App
//
//  Created by Roman Roba on 08/09/16.
//  Copyright © 2016 Roman Roba. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FoodDetailTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *mealLabel;
@property (weak, nonatomic) IBOutlet UILabel *sizeLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@end
