//
//  Form1TableViewController.m
//  FinalPatientForm
//
//  Created by Peeyush on 08/09/14.
//  Copyright (c) 2014 sutherland. All rights reserved.
//

#import "Form1TableViewController.h"
#import "SelectTableViewController.h"
#import "PreviewTableViewController.h"
#import "DisclosorIndicatorTableViewCell.h"
#import "TextFieldTableViewCell.h"
#import "TextViewTableViewCell.h"
#import "GlobalData.h"

@interface Form1TableViewController () {
    
    NSMutableArray *sectionArray;
    NSMutableArray *patientInfoArray;
}

@end

@implementation Form1TableViewController

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
    self.title = @"Health Risk Assessment Form";
    
    [self createBarButtons];
    
    GlobalData *obj = [GlobalData getInstance];
    patientInfoArray = obj.patientInfoArray;
    sectionArray = obj.sectionArray;
}

- (void) viewWillAppear:(BOOL)animated {
    
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void) createBarButtons {
    
    UIButton *submitButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [submitButton addTarget:self
                     action:@selector(submitView:)
           forControlEvents:UIControlEventTouchUpInside];
    [submitButton setTitle:@"Submit" forState:UIControlStateNormal];
    submitButton.titleLabel.font = [UIFont boldSystemFontOfSize:15.0];
    submitButton.frame = CGRectMake(0.0, 0.0, 60.0, 45.0);
    UIBarButtonItem *aBarButtonItem = [[UIBarButtonItem alloc]  initWithCustomView:submitButton];
    
    UIButton *clearButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [clearButton addTarget:self
                    action:@selector(clearView:)
          forControlEvents:UIControlEventTouchUpInside];
    [clearButton setTitle:@"Clear" forState:UIControlStateNormal];
    clearButton.frame = CGRectMake(0.0, 0.0, 60.0, 45.0);
    clearButton.titleLabel.font = [UIFont boldSystemFontOfSize:15.0];
    UIBarButtonItem *cBarButtonItem = [[UIBarButtonItem alloc]  initWithCustomView:clearButton];
    
    NSArray *items = [NSArray arrayWithObjects:aBarButtonItem, cBarButtonItem, nil];
    self.navigationItem.rightBarButtonItems = items;
}

- (void) clearView:(id)sender {
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert!" message:@"Do you want to clear all the data?" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil, nil];
    [alertView show];
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
   // NSString *tagStr = [NSString stringWithFormat:@"%d%d", indexPath.section+1, indexPath.row];
    if ([[infoDict objectForKey:@"control"] isEqualToString:@"TextField"]) {
        TextFieldTableViewCell *cell = (TextFieldTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"TextFieldTableViewCell"];
        if (cell == nil) {
            
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"TextFieldTableViewCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        cell.textFieldLabel.text = [infoDict objectForKey:@"name"];
        cell.cellTextField.text = [infoDict objectForKey:@"selectedValue"];
        cell.cellTextField.tag = indexPath.row;
        cell.cellTextField.delegate = self;
        cell.cellTextField.placeholder = [NSString stringWithFormat:@"enter your %@", [infoDict objectForKey:@"name"]];
        return cell;
    }else if ([[infoDict objectForKey:@"control"] isEqualToString:@"DisclosureIndicator"]) {
        DisclosorIndicatorTableViewCell *cell = (DisclosorIndicatorTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"DisclosorIndicatorTableViewCell"];
        if (cell == nil) {
            
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"DisclosorIndicatorTableViewCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        cell.textLabel.text= [infoDict objectForKey:@"name"];
        cell.detailTextLabel.text = [infoDict objectForKey:@"selectedValue"];
        return cell;
    }else if ([[infoDict objectForKey:@"control"] isEqualToString:@"TextView"]) {
        TextViewTableViewCell *cell = (TextViewTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"TextViewTableViewCell"];
        if (cell == nil) {
            
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"TextViewTableViewCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        cell.textViewLabel.text = [infoDict objectForKey:@"name"];
        cell.cellTextView.text = [infoDict objectForKey:@"selectedValue"];
        cell.cellTextView.tag = indexPath.row;
        cell.cellTextView.delegate = self;
        return cell;
    }
    return 0;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    NSMutableDictionary *dict1 = [sectionArray objectAtIndex:section];
    return [dict1 objectForKey:@"title"];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSMutableArray *infoArr = [patientInfoArray objectAtIndex:indexPath.section];
    NSMutableDictionary *infoDict = [infoArr objectAtIndex:indexPath.row];
    if ([[infoDict objectForKey:@"control"] isEqualToString:@"DisclosureIndicator"]) {
        SelectTableViewController *sv = [self.storyboard instantiateViewControllerWithIdentifier:@"SelectTableViewController"];
        sv.rowArray = [[infoDict objectForKey:@"selectValue"] componentsSeparatedByString:@","];
        sv.viewTitle = [infoDict objectForKey:@"name"];
        sv.sectionInt = indexPath.section;
        sv.rowInt = indexPath.row;
        [self.navigationController pushViewController:sv animated:YES];
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55.0;
}

- (void)textViewDidEndEditing:(UITextView *)sender{
    GlobalData *obj = [GlobalData getInstance];
    NSMutableArray *infoArr = [[NSMutableArray alloc] initWithArray:[obj.patientInfoArray objectAtIndex:1]];
    NSMutableDictionary *infoDict = [[NSMutableDictionary alloc] initWithDictionary:[infoArr objectAtIndex:sender.tag]];
    [infoDict setObject:sender.text forKey:@"selectedValue"];
    [infoArr insertObject:infoDict atIndex:sender.tag];
    [infoArr removeObjectAtIndex:sender.tag+1];
    [obj.patientInfoArray insertObject:infoArr atIndex:1];
    [obj.patientInfoArray removeObjectAtIndex:1+1];
}

- (void)textFieldDidEndEditing:(UITextField *)sender
{
    GlobalData *obj = [GlobalData getInstance];
    NSMutableArray *infoArr = [[NSMutableArray alloc] initWithArray:[obj.patientInfoArray objectAtIndex:0]];
    NSMutableDictionary *infoDict = [[NSMutableDictionary alloc] initWithDictionary:[infoArr objectAtIndex:sender.tag]];
    [infoDict setObject:sender.text forKey:@"selectedValue"];
    [infoArr insertObject:infoDict atIndex:sender.tag];
    [infoArr removeObjectAtIndex:sender.tag+1];
    [obj.patientInfoArray insertObject:infoArr atIndex:0];
    [obj.patientInfoArray removeObjectAtIndex:0+1];
}

- (void) submitView:(id) sender {

    PreviewTableViewController *pv = [self.storyboard instantiateViewControllerWithIdentifier:@"PreviewTableViewController"];
    [self.navigationController pushViewController:pv animated:YES];
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger) buttonIndex {
    
        if (buttonIndex == 1) {
            GlobalData *obj = [GlobalData getInstance];
            
            for (int i=0; i<[sectionArray count]; i++) {
                NSMutableArray *infoArr = [[NSMutableArray alloc] initWithArray:[obj.patientInfoArray objectAtIndex:i]];
                for (int j=0; j<[infoArr count]; j++) {
                    NSMutableDictionary *infoDict = [[NSMutableDictionary alloc] initWithDictionary:[infoArr objectAtIndex:j]];
                    [infoDict removeObjectForKey:@"selectedValue"];
                    [infoArr insertObject:infoDict atIndex:j];
                    [infoArr removeObjectAtIndex:j+1];
                }
                [obj.patientInfoArray insertObject:infoArr atIndex:i];
                [obj.patientInfoArray removeObjectAtIndex:i+1];
            }
            [self.tableView reloadData];
        }
    
}

@end
