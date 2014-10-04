//
//  EditForm1TableViewController.m
//  FinalPatientForm
//
//  Created by Peeyush on 11/09/14.
//  Copyright (c) 2014 sutherland. All rights reserved.
//

#import "EditForm1TableViewController.h"
#import "GlobalData.h"

@interface EditForm1TableViewController () {
    NSString *editData;
}
- (UITextField *) textFieldBuilt:(NSInteger)tag;
- (UITextView *) textViewBuilt:(NSInteger)tag;
@end

@implementation EditForm1TableViewController
@synthesize titleStr, placeHolderStr, sectionInt, rowInt, controlStr;

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
    self.title = self.titleStr;
    self.navigationItem.hidesBackButton = YES;
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc]
                                   initWithTitle:@"Done"
                                   style:UIBarButtonItemStyleDone
                                   target:self
                                   action:@selector(flipView:)];
    self.navigationItem.rightBarButtonItem = doneButton;
    
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
    if (editData != nil) {
        [infoDict setObject:editData forKey:@"selectedValue"];
        [infoArr insertObject:infoDict atIndex:self.rowInt];
        [infoArr removeObjectAtIndex:self.rowInt+1];
        [obj.patientInfoArray insertObject:infoArr atIndex:self.sectionInt];
        [obj.patientInfoArray removeObjectAtIndex:self.sectionInt+1];
    }
    NSLog(@"Dict:%@", infoDict);
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:  indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    if ([self.controlStr isEqualToString:@"TextField"]) {
        [cell addSubview:[self textFieldBuilt:indexPath.row]];
    }else if ([self.controlStr isEqualToString:@"TextView"]) {
        [cell addSubview:[self textViewBuilt:indexPath.row]];
    }
    
    cell.textLabel.text = self.titleStr;
 
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100.0;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    NSLog(@"TxtFieldTag:%d",textField.tag);
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    NSLog(@"TxtFieldText1:%@",textField.text);
    editData = textField.text;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    //NSLog(@"TxtFieldText:%@",textField.text);
    return YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    NSLog(@"TxtViewdText1:%@",textView.text);
    editData = textView.text;
}

- (UITextField *) textFieldBuilt:(NSInteger)tag {
    
    CGRect frame3 = CGRectMake(403.0, 0.5, 330.0, 99.0);
    UITextField *txtField; txtField = [[UITextField alloc] initWithFrame:frame3];
    txtField.borderStyle = UITextBorderStyleNone;
    txtField.textColor = [UIColor blackColor];
    txtField.font = [UIFont systemFontOfSize:17.0];
    txtField.text = self.placeHolderStr;
    txtField.tag = tag;
    txtField.backgroundColor = [UIColor clearColor];
    txtField.autocorrectionType = UITextAutocorrectionTypeNo;
    txtField.keyboardType = UIKeyboardTypeDefault;
    txtField.returnKeyType = UIReturnKeyDefault;
    txtField.textAlignment = NSTextAlignmentRight;
    txtField.delegate = self;
    return txtField;
}

- (UITextView *) textViewBuilt:(NSInteger)tag {
    
    UITextView *txtView = [[UITextView alloc] initWithFrame:CGRectMake(403.0, 0.5, 330.0, 98.0)];
    txtView.textAlignment = NSTextAlignmentRight;
    txtView.font = [UIFont systemFontOfSize:17.0];
    txtView.text = self.placeHolderStr;
    txtView.delegate = self;
    return txtView;
}

@end
