//
//  FoodExpandableTableViewController.h
//  Garwan - Food App
//
//  Created by Roman Roba on 08/09/16.
//  Copyright © 2016 Roman Roba. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FoodExpandableTableViewController : UITableViewController
{
    BOOL amIMaster;
    BOOL sameRow;
    NSArray *tablesData;
    NSIndexPath *selectedIndex;
    FoodExpandableTableViewController *addonsTable;
}

@end
