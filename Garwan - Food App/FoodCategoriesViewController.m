//
//  FoodCategoriesViewController.m
//  Garwan - Food App
//
//  Created by Roman Roba on 08/09/16.
//  Copyright © 2016 Roman Roba. All rights reserved.
//

#import "FoodCategoriesViewController.h"
#import "FoodAddonsViewController.h"
#import "FoodExpandableTableViewController.h"

@interface FoodCategoriesViewController ()

@end

@implementation FoodCategoriesViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //http://stackoverflow.com/questions/24329503/on-ios8-displaying-my-app-in-landscape-mode-will-hide-the-status-bar-but-on-ios
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationNone];
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([[segue identifier] isEqualToString:@"FoodCategoriesToFoodTableViewControllerSegue"])
    {
        foodTable = [segue destinationViewController];
    }
    else if ([[segue identifier] isEqualToString:@"FoodCategoriesToFoodAddonsSegue"])
    {
        FoodAddonsViewController *favc = [segue destinationViewController];
        favc.navigationItem.title = @"Food Addons";
    }
}


@end
