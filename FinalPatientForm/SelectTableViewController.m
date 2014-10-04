//
//  SelectTableViewController.m
//  FinalPatientForm
//
//  Created by Peeyush on 08/09/14.
//  Copyright (c) 2014 sutherland. All rights reserved.
//

#import "SelectTableViewController.h"
#import "GlobalData.h"

@interface SelectTableViewController () {
    
    NSString *selectStr;
    BOOL aBool;
    NSIndexPath *lastIndexPath;
}

@end

@implementation SelectTableViewController
@synthesize rowArray, viewTitle, sectionInt, rowInt;

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
    self.title = self.viewTitle;
    self.navigationItem.hidesBackButton = YES;
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
    
    GlobalData *obj = [GlobalData getInstance];
    NSMutableArray *infoArr = [[NSMutableArray alloc] initWithArray:[obj.patientInfoArray objectAtIndex:self.sectionInt]];
    NSMutableDictionary *infoDict = [[NSMutableDictionary alloc] initWithDictionary:[infoArr objectAtIndex:self.rowInt]];
    
    if (selectStr != nil) {
        [infoDict setObject:selectStr forKey:@"selectedValue"];
        [infoArr insertObject:infoDict atIndex:self.rowInt];
        [infoArr removeObjectAtIndex:self.rowInt+1];
        [obj.patientInfoArray insertObject:infoArr atIndex:self.sectionInt];
        [obj.patientInfoArray removeObjectAtIndex:self.sectionInt+1];
    }
    NSLog(@"Arr1:%@", infoDict);
    [self.navigationController popViewControllerAnimated:YES];
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
    GlobalData *obj = [GlobalData getInstance];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = [self.rowArray objectAtIndex:indexPath.row];
    NSMutableArray *infoArr = [[NSMutableArray alloc] initWithArray:[obj.patientInfoArray objectAtIndex:self.sectionInt]];
    NSMutableDictionary *infoDict = [[NSMutableDictionary alloc] initWithDictionary:[infoArr objectAtIndex:self.rowInt]];
    if ([[self.rowArray objectAtIndex:indexPath.row] isEqualToString:[infoDict objectForKey:@"selectedValue"]]) {
        aBool = TRUE;
        lastIndexPath = indexPath;
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }else
        cell.accessoryType = UITableViewCellAccessoryNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"Row:%d",indexPath.row);
    NSLog(@"Index Path:%d",indexPath.item);
    UITableViewCell* cell = [tableView cellForRowAtIndexPath:indexPath];
    selectStr = cell.textLabel.text;
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    if (aBool) {
        aBool = FALSE;
        UITableViewCell *oldCell = [tableView cellForRowAtIndexPath:lastIndexPath];
        if ([indexPath isEqual:lastIndexPath]) {
            oldCell.accessoryType = UITableViewCellAccessoryCheckmark;
        }else {
            oldCell.accessoryType = UITableViewCellAccessoryNone;
        }
        
    }
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"Row1:%d",indexPath.row);
    UITableViewCell* cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryNone;
}

@end
