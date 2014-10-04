//
//  RegistrationTableViewController.m
//  FinalPatientForm
//
//  Created by Peeyush on 15/09/14.
//  Copyright (c) 2014 sutherland. All rights reserved.
//

#import "RegistrationTableViewController.h"

@interface RegistrationTableViewController () {
    
    BOOL alertBool1;
}
@end

@implementation RegistrationTableViewController
@synthesize fstNameLabel, firstNameTxtField, lastNameTxtField, mobileNoTxtField;
@synthesize emailTxtField, passwordTxtField, rePasswordTxtField;

- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

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
    
    self.fstNameLabel.text = @"First Name";
    self.title = @"New Registration";
    
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    gestureRecognizer.cancelsTouchesInView = NO;
    [self.tableView addGestureRecognizer:gestureRecognizer];
    
    [self.tableView setBackgroundView:nil];
    self.tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"yellow.jpg"]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)textFieldDoneEditing:(id)sender {
    
    [sender resignFirstResponder];
}

- (void) hideKeyboard {
    
    [self.firstNameTxtField resignFirstResponder];
    [self.lastNameTxtField resignFirstResponder];
    [self.mobileNoTxtField resignFirstResponder];
    [self.emailTxtField resignFirstResponder];
    [self.passwordTxtField resignFirstResponder];
    [self.rePasswordTxtField resignFirstResponder];
}

- (IBAction)registerButtonTapped:(id)sender {
    
    BOOL alertBool = '\0';
    NSManagedObjectContext *context = [self managedObjectContext];
    NSManagedObject *newRegistration = [NSEntityDescription insertNewObjectForEntityForName:@"RegisteredUsers" inManagedObjectContext:context];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"RegisteredUsers"];
    NSMutableArray *registeredUsersArray = [[context executeFetchRequest:fetchRequest error:nil] mutableCopy];
    
    if ([self.firstNameTxtField.text isEqualToString:@""]) {
        [self alertStatus:@"Please enter your First Name." :@"Alert!"];
    }else if ([self.mobileNoTxtField.text isEqualToString:@""]) {
        [self alertStatus:@"Please enter Mobile No." :@"Alert!"];
    }else if ([self.emailTxtField.text isEqualToString:@""]) {
        [self alertStatus:@"Please enter Email Id." :@"Alert!"];
    }else if ([self.passwordTxtField.text isEqualToString:@""]) {
        [self alertStatus:@"Please enter Password." :@"Alert!"];
    }else if ([self.rePasswordTxtField.text isEqualToString:@""] || ![self.rePasswordTxtField.text isEqualToString:self.passwordTxtField.text]) {
        [self alertStatus:@"Password and Re-password should be same." :@"Alert!"];
    }else {
        if ([registeredUsersArray count] != 0) {
            alertBool1 = FALSE;
            for (NSManagedObject *keyValue in registeredUsersArray) {
                alertBool = TRUE;
                if ([[keyValue valueForKey:@"email"] isEqualToString:self.emailTxtField.text]) {
                    alertBool = FALSE;
                    [self alertStatus:@"This email is already registered. Please use other email Id." :@"Alert!"];
                    break;
                }else if ([[keyValue valueForKey:@"mobileNo"] isEqualToString:self.mobileNoTxtField.text]) {
                    alertBool = FALSE;
                    [self alertStatus:@"This Mobile No. is already registered. Please use other Mobile No." :@"Alert!"];
                    break;
                }
            }
            if (alertBool) {
                alertBool1 = TRUE;
                NSManagedObjectContext *context = [self managedObjectContext];
                [newRegistration setValue:self.firstNameTxtField.text forKey:@"firstName"];
                [newRegistration setValue:self.lastNameTxtField.text forKey:@"lastName"];
                [newRegistration setValue:self.mobileNoTxtField.text forKey:@"mobileNo"];
                [newRegistration setValue:self.emailTxtField.text forKey:@"email"];
                [newRegistration setValue:self.passwordTxtField.text forKey:@"password"];
                
                NSError *error = nil;
                if (![context save:&error]) {
                    NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
                }
                [self alertStatus:@"Registered successfully." :@"Alert!"];

            }
        }else {
            alertBool1 = TRUE;
            [newRegistration setValue:self.firstNameTxtField.text forKey:@"firstName"];
            [newRegistration setValue:self.lastNameTxtField.text forKey:@"lastName"];
            [newRegistration setValue:self.mobileNoTxtField.text forKey:@"mobileNo"];
            [newRegistration setValue:self.emailTxtField.text forKey:@"email"];
            [newRegistration setValue:self.passwordTxtField.text forKey:@"password"];
            
            NSError *error = nil;
            if (![context save:&error]) {
                NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
            }
            [self alertStatus:@"You are Registered successfully." :@"Alert!"];
        }
    }
}

- (void) alertStatus:(NSString *)msg :(NSString *) title
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alertView show];
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger) buttonIndex {
    
    if (alertBool1)
        if (buttonIndex == 0) {
            alertBool1 = FALSE;
            [self.navigationController popViewControllerAnimated:YES];
        }
    
}

@end
