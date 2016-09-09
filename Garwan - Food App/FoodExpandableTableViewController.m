//
//  FoodExpandableTableViewController.m
//  Garwan - Food App
//
//  Created by Roman Roba on 08/09/16.
//  Copyright © 2016 Roman Roba. All rights reserved.
//

#import "FoodExpandableTableViewController.h"
#import "FoodExpandableTableViewCell.h"
#import "FoodDetailTableViewCell.h"
#import "DataRetriever.h"
#import "FoodCategory.h"
#import "Food.h"

#define ROW_HEIGHT 44

@implementation FoodExpandableTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tableDataReceived:) name:DATA_RETRIEVED object:nil];
    
    categories = [[NSMutableArray alloc] init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableDataReceived:(NSNotification *)notification
{
    categories = [notification.userInfo valueForKey:DATA_RETRIEVED];
    [self.tableView reloadData];
}

#pragma mark -
#pragma mark Expandable Table View

- (NSInteger)numberOfExpandableSectionsInTableView
{
    return categories.count;
}

- (UITableViewCell*)cellForExpandable:(UITableView *)tableView RowAtIndexPath:(NSIndexPath *)indexPath
{
    FoodExpandableTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FoodExpandableViewCell" forIndexPath:indexPath];
    
    FoodCategory *fc = categories[indexPath.row];
    [cell.categoryLabel setText:fc.name];
    
    return cell;
}

- (CGFloat)heightForExpandableRowAtIndexPath:(NSIndexPath *)indexPath
{
    FoodCategory *fc = categories[indexPath.row];
    
    if(selectedIndex && indexPath.row == selectedIndex.row && !sameRow) return ROW_HEIGHT + ROW_HEIGHT * fc.meals.count;
    else return ROW_HEIGHT;
}

- (void)didSelectExpandable:(UITableView *)tableView RowAtIndexPath:(NSIndexPath *)indexPath
{
    if (selectedIndex && indexPath.row == selectedIndex.row && !sameRow) sameRow = YES;
    else sameRow = NO;
    
    NSMutableArray *indexes = [[NSMutableArray alloc] initWithObjects:indexPath, selectedIndex ? selectedIndex : nil, nil];
    selectedIndex = indexPath;
    
    [tableView beginUpdates];
    [tableView reloadRowsAtIndexPaths:indexes withRowAnimation:UITableViewRowAnimationAutomatic];
    [tableView endUpdates];
    
    FoodExpandableTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell.detailTableView reloadData];
}

#pragma mark -
#pragma mark Detail Table View

- (NSInteger)numberOfDetailSectionsInTableView
{
    if (selectedIndex && !sameRow)
    {
        FoodCategory *fc = categories[selectedIndex.row];
        return fc.meals.count;
    }
    return 0;
}

- (UITableViewCell*)cellForDetail:(UITableView *)tableView RowAtIndexPath:(NSIndexPath *)indexPath
{
    FoodDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FoodDetailTableViewCell" forIndexPath:indexPath];
    
    FoodCategory *fc = categories[selectedIndex.row];
    Food *food = fc.meals[indexPath.row];
    
    [cell.mealLabel setText:food.name];
    [cell.sizeLabel setText:food.size];
    [cell.priceLabel setText:[NSString stringWithFormat:@"%@€", food.price]];
    
    if (!food.hasAddons) cell.selectionStyle = UITableViewCellSelectionStyleNone;
    else cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    
    return cell;
}

- (CGFloat)heightForDetailRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ROW_HEIGHT;
}

- (void)didSelectDetail:(UITableView *)tableView RowAtIndexPath:(NSIndexPath *)indexPath
{
    FoodDetailTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell.selectionStyle == UITableViewCellSelectionStyleNone) return;
    
    [self performSegueWithIdentifier:@"FoodCategoriesToFoodAddonsSegue" sender:cell];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark -
#pragma mark Table View Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([tableView.restorationIdentifier isEqualToString:@"FoodExpandable"])
    {
        return [self numberOfExpandableSectionsInTableView];
    }
    else return [self numberOfDetailSectionsInTableView];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView.restorationIdentifier isEqualToString:@"FoodExpandable"])
    {
        return [self cellForExpandable:tableView RowAtIndexPath:indexPath];
    }
    else return [self cellForDetail:tableView RowAtIndexPath:indexPath];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView.restorationIdentifier isEqualToString:@"FoodExpandable"])
    {
        return [self heightForExpandableRowAtIndexPath:indexPath];
    }
    else return [self heightForDetailRowAtIndexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView.restorationIdentifier isEqualToString:@"FoodExpandable"])
    {
        [self didSelectExpandable:tableView RowAtIndexPath:indexPath];
    }
    else [self didSelectDetail:tableView RowAtIndexPath:indexPath];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([[segue identifier] isEqualToString:@"FoodCategoriesToFoodAddonsSegue"])
    {
        FoodDetailTableViewCell *cell = sender;
//        if (cell.selectionStyle == UITableViewCellSelectionStyleNone) return;
        
        UIViewController *favc = [segue destinationViewController];
        favc.navigationItem.title = cell.mealLabel.text;
    }
}

#pragma mark - 
#pragma mark Deallock

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
