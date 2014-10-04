//
//  LoginTableViewController.m
//  FinalPatientForm
//
//  Created by Peeyush on 17/09/14.
//  Copyright (c) 2014 sutherland. All rights reserved.
//

#import "LoginTableViewController.h"
#import "Form1TableViewController.h"
#import "Form2TableViewController.h"

@interface LoginTableViewController ()
- (void) createLogoImageView;
@end

@implementation LoginTableViewController
@synthesize label, userNameTxtField, passwordTextField;

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
    
    self.label.text = @"";
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    gestureRecognizer.cancelsTouchesInView = NO;
    [self.tableView addGestureRecognizer:gestureRecognizer];
    
    [self createLogoImageView];
    
    [self.tableView setBackgroundView:nil];
    self.tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"yellow.jpg"]];
    
    self.userNameTxtField.text = @"peez";
    self.passwordTextField.text = @"12345";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)textFieldDoneEditing:(id)sender {
    
    [sender resignFirstResponder];
}

- (void) hideKeyboard {
    
    [self.userNameTxtField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
}

- (void) createLogoImageView {
    
    UIImageView *dot =[[UIImageView alloc] initWithFrame:CGRectMake(230,120,350,150)];
    dot.image=[UIImage imageNamed:@"sutherland_logo.png"];
    [self.view addSubview:dot];
}

- (IBAction)loginButtonTapped:(id)sender {
    
    BOOL alertBool = '\0';
    NSManagedObjectContext *context = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"RegisteredUsers"];
    NSMutableArray *registeredUsersArray = [[context executeFetchRequest:fetchRequest error:nil] mutableCopy];
    
    if ([self.userNameTxtField.text isEqualToString:@""]) {
        [self alertStatus:@"Please User Name." :@"Alert!"];
    }else if ([self.passwordTextField.text isEqualToString:@""]) {
        [self alertStatus:@"Please enter Password" :@"Alert!"];
    }else {
        for (NSManagedObject *keyValue in registeredUsersArray) {
            alertBool = TRUE;
            if (![[keyValue valueForKey:@"firstName"] isEqualToString:self.userNameTxtField.text]) {
                alertBool = FALSE;
                [self alertStatus:@"Your are not Registered User. Please Register yourself." :@"Alert!"];
                break;
            }else if (![[keyValue valueForKey:@"password"] isEqualToString:self.passwordTextField.text]) {
                alertBool = FALSE;
                [self alertStatus:@"Entered Password is incorrect. Please enter correct Password." :@"Alert!"];
                break;
            }
        }
        if (alertBool) {
            Form2TableViewController *fv = [self.storyboard instantiateViewControllerWithIdentifier:@"Form2TableViewController"];
            [self.navigationController pushViewController:fv animated:YES];
        }
    }
}

- (void) alertStatus:(NSString *)msg :(NSString *) title
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alertView show];
}

@end
