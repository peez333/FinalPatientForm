//
//  SelectForm2TableViewController.m
//  FinalPatientForm
//
//  Created by Peeyush on 23/09/14.
//  Copyright (c) 2014 sutherland. All rights reserved.
//

#import "SelectForm2TableViewController.h"

@interface SelectForm2TableViewController (){
    
    NSString *selectStr;
    BOOL aBool;
    NSIndexPath *lastIndexPath;
}
@end

@implementation SelectForm2TableViewController
@synthesize rowArray, viewTitle, sectionInt, rowInt, userSelectStr;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
   // self.navigationItem.hidesBackButton = YES;
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc]
                                   initWithTitle:@"Done"
                                   style:UIBarButtonItemStyleDone
                                   target:self
                                   action:@selector(flipView:)];
    self.navigationItem.rightBarButtonItem = doneButton;
    aBool = FALSE;
    
    [self.tableView setBackgroundView:nil];
    self.tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"yellow.jpg"]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void) flipView:(id) sender {

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.rowArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = [self.rowArray objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"Row:%d",indexPath.row);
    NSLog(@"Index Path:%d",indexPath.item);
    UITableViewCell* cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if ([self.userSelectStr isEqualToString:@"single"]) {
        selectStr = cell.textLabel.text;
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
//        if (aBool) {
//            aBool = FALSE;
//            UITableViewCell *oldCell = [tableView cellForRowAtIndexPath:lastIndexPath];
//            if ([indexPath isEqual:lastIndexPath]) {
//                oldCell.accessoryType = UITableViewCellAccessoryCheckmark;
//            }else {
//                oldCell.accessoryType = UITableViewCellAccessoryNone;
//            }
//
//        }
    }else if ([self.userSelectStr isEqualToString:@"multiple"]) {
        if (cell.accessoryType == UITableViewCellAccessoryNone) {
            selectStr = cell.textLabel.text;
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }else if (cell.accessoryType == UITableViewCellAccessoryCheckmark) {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
    }
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"Row1:%d",indexPath.row);
    UITableViewCell* cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if ([self.userSelectStr isEqualToString:@"single"]) {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
}

@end
