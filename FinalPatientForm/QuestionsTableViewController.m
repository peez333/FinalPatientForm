//
//  QuestionsTableViewController.m
//  FinalPatientForm
//
//  Created by Peeyush on 22/09/14.
//  Copyright (c) 2014 sutherland. All rights reserved.
//

#import "QuestionsTableViewController.h"
#import "DisclosorIndicatorTableViewCell.h"
#import "TextFieldTableViewCell.h"
#import "SelectForm2TableViewController.h"
#import "GlobalData.h"

@interface QuestionsTableViewController ()

@end

@implementation QuestionsTableViewController
@synthesize rowArray, sectionInt, rowInt;

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
    
    [self.tableView setBackgroundView:nil];
    self.tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"yellow.jpg"]];
    
    NSLog(@"Section:%d", self.sectionInt);
    NSLog(@"Row:%d", self.rowInt);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.rowArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableDictionary *infoDict = [self.rowArray objectAtIndex:indexPath.section];
    
    if ([[infoDict objectForKey:@"control"] isEqualToString:@"TextField"]) {
        TextFieldTableViewCell *cell = (TextFieldTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"TextFieldTableViewCell"];
        if (cell == nil) {
            
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"TextFieldTableViewCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        cell.textFieldLabel.numberOfLines = 3;
        //cell.textFieldLabel.lineBreakMode = UILineBreakModeWordWrap;
        cell.textFieldLabel.text = [infoDict objectForKey:@"question"];
        cell.cellTextField.text = [infoDict objectForKey:@"selectedValue"];
        cell.cellTextField.tag = indexPath.section;
        cell.cellTextField.delegate = self;
        cell.cellTextField.placeholder = [NSString stringWithFormat:@"enter your answer"];
        return cell;
    }else if ([[infoDict objectForKey:@"control"] isEqualToString:@"DisclosureIndicator"]) {
        DisclosorIndicatorTableViewCell *cell = (DisclosorIndicatorTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"DisclosorIndicatorTableViewCell"];
        if (cell == nil) {
            
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"DisclosorIndicatorTableViewCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        cell.textLabel.numberOfLines = 2;
        cell.textLabel.text= [infoDict objectForKey:@"question"];
        cell.detailTextLabel.text = [infoDict objectForKey:@"selectedValue"];
        return cell;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"Row:%d of Section:%d iz Tapped!", indexPath.row, indexPath.section);
    
    NSMutableDictionary *infoDict = [self.rowArray objectAtIndex:indexPath.section];
    NSLog(@"%@",[infoDict objectForKey:@"selectValue"]);
    SelectForm2TableViewController *sv = [self.storyboard instantiateViewControllerWithIdentifier:@"SelectForm2TableViewController"];
    sv.rowArray = [[infoDict objectForKey:@"selectValue"] componentsSeparatedByString:@","];
    sv.userSelectStr = [infoDict objectForKey:@"userSelect"];
    [self.navigationController pushViewController:sv animated:YES];
}

- (void)textFieldDidEndEditing:(UITextField *)sender
{
    NSInteger sec = self.sectionInt;
    GlobalData *obj = [GlobalData getInstance];
    NSLog(@"form2PatientInfoArray:%@", obj.form2PatientInfoArray);
    NSLog(@"form2PatientInfoArrayCount:%d", [obj.form2PatientInfoArray count]);
    NSMutableArray *infoArr1 = [[NSMutableArray alloc] initWithArray:[obj.form2PatientInfoArray objectAtIndex:sec]];
   // NSLog(@"infoArr1:%@",infoArr1);
    NSMutableDictionary *infoDict1 = [[NSMutableDictionary alloc] initWithDictionary:[infoArr1 objectAtIndex:self.rowInt]];
    NSMutableArray *infoArr2 = [[NSMutableArray alloc] initWithArray:[infoDict1 objectForKey:@"info"]];
    NSMutableDictionary *infoDict2 = [[NSMutableDictionary alloc] initWithDictionary:[infoArr2 objectAtIndex:sender.tag]];
   // NSLog(@"infoDict2:%@",infoDict2);
    [infoDict2 setObject:sender.text forKey:@"selectedValue"];
   // NSLog(@"infoDict21:%@",infoDict2);
    NSLog(@"infoArr2:%@",infoArr2);
    [infoArr2 insertObject:infoDict2 atIndex:sender.tag];
    [infoArr2 removeObjectAtIndex:sender.tag+1];
    NSLog(@"infoArr21:%@",infoArr2);
    [infoDict1 setObject:infoArr2 forKey:@"info"];
    [obj.form2PatientInfoArray insertObject:infoDict1 atIndex:sec];
    [obj.form2PatientInfoArray removeObjectAtIndex:sec+1];
    NSLog(@"form2PatientInfoArrayCount1:%d", [obj.form2PatientInfoArray count]);
    NSLog(@"form2PatientInfoArray1:%@", obj.form2PatientInfoArray);
}

@end
