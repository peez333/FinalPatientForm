//
//  Form2TableViewController.m
//  FinalPatientForm
//
//  Created by Peeyush on 22/09/14.
//  Copyright (c) 2014 sutherland. All rights reserved.
//

#import "Form2TableViewController.h"
#import "DisclosorIndicatorTableViewCell.h"
#import "QuestionsTableViewController.h"
#import "GlobalData.h"

@interface Form2TableViewController () {
    
    NSMutableArray *sectionArray;
    NSMutableArray *patientInfoArray;
}

@end

@implementation Form2TableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Health Risk Assessment Form2";
    
    GlobalData *obj = [GlobalData getInstance];
    patientInfoArray = obj.form2PatientInfoArray;
    sectionArray = obj.form2SectionArray;
    
    [self.tableView setBackgroundView:nil];
    self.tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"yellow.jpg"]];
}

- (void) viewWillAppear:(BOOL)animated {
    
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [sectionArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[patientInfoArray objectAtIndex:section] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableArray *infoArr = [patientInfoArray objectAtIndex:indexPath.section];
    NSMutableDictionary *infoDict = [infoArr objectAtIndex:indexPath.row];
    
    DisclosorIndicatorTableViewCell *cell = (DisclosorIndicatorTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"DisclosorIndicatorTableViewCell"];
    if (cell == nil) {
        
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"DisclosorIndicatorTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    cell.textLabel.text= [infoDict objectForKey:@"title"];
    cell.detailTextLabel.text = [infoDict objectForKey:@"selectedValue"];
    cell.backgroundColor = [UIColor clearColor];

    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    NSMutableDictionary *dict1 = [sectionArray objectAtIndex:section];
    return [dict1 objectForKey:@"title"];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"Row:%d of Section:%d iz Tapped!", indexPath.row, indexPath.section);
    
    NSMutableArray *infoArr = [patientInfoArray objectAtIndex:indexPath.section];
    NSMutableDictionary *infoDict = [infoArr objectAtIndex:indexPath.row];
    
    QuestionsTableViewController *qv = [self.storyboard instantiateViewControllerWithIdentifier:@"QuestionsTableViewController"];
    qv.rowArray = [infoDict objectForKey:@"info"];
    qv.sectionInt = indexPath.section;
    qv.rowInt = indexPath.row;
    [self.navigationController pushViewController:qv animated:YES];
}

@end
