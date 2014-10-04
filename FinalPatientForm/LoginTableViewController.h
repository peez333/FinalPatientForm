//
//  LoginTableViewController.h
//  FinalPatientForm
//
//  Created by Peeyush on 17/09/14.
//  Copyright (c) 2014 sutherland. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginTableViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UITextField *userNameTxtField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

- (IBAction)loginButtonTapped:(id)sender;
- (IBAction)textFieldDoneEditing:(id)sender;

@end
