//
//  RegistrationTableViewController.h
//  FinalPatientForm
//
//  Created by Peeyush on 15/09/14.
//  Copyright (c) 2014 sutherland. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegistrationTableViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UILabel *fstNameLabel;
@property (weak, nonatomic) IBOutlet UITextField *firstNameTxtField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameTxtField;
@property (weak, nonatomic) IBOutlet UITextField *mobileNoTxtField;
@property (weak, nonatomic) IBOutlet UITextField *emailTxtField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTxtField;
@property (weak, nonatomic) IBOutlet UITextField *rePasswordTxtField;

- (IBAction)registerButtonTapped:(id)sender;
- (IBAction)textFieldDoneEditing:(id)sender;

@end
