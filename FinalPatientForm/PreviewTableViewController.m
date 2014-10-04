//
//  PreviewTableViewController.m
//  FinalPatientForm
//
//  Created by Peeyush on 10/09/14.
//  Copyright (c) 2014 sutherland. All rights reserved.
//

#import "PreviewTableViewController.h"
#import "EditForm1TableViewController.h"
#import "SelectTableViewController.h"
#import "GlobalData.h"

@interface PreviewTableViewController () {
    
    NSMutableArray *sectionArray;
    
    NSMutableArray *patientInfoArray;
    
    UIBarButtonItem *printButton;
    UIBarButtonItem *emailButton;
    
    UIImage *newImage;
}
- (void) pushEditForm:(NSInteger)sec push:(NSInteger)row;
- (void) pushEditForm1:(NSInteger)sec push:(NSInteger)row;

@end

@implementation PreviewTableViewController

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
    
    self.title = @"Health Risk Assessment Form Preview";
   /* printButton = [[UIBarButtonItem alloc]
                                     initWithTitle:@"Print"
                                     style:UIBarButtonItemStyleDone
                                     target:self
                                     action:@selector(printView:)];
    self.navigationItem.rightBarButtonItem = printButton;*/
    
    GlobalData *obj = [GlobalData getInstance];
    patientInfoArray = obj.patientInfoArray;
    sectionArray = obj.sectionArray;
    
    [self.tableView setBackgroundView:nil];
    self.tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"yellow.jpg"]];
    
    [self createBarButtons];
    
    [self convertViewToFile];
}

- (void) viewWillAppear:(BOOL)animated {
    
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void) createBarButtons {
    
    UIButton *printButton1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [printButton1 addTarget:self
                     action:@selector(printView:)
           forControlEvents:UIControlEventTouchUpInside];
    [printButton1 setTitle:@"Print" forState:UIControlStateNormal];
    printButton1.titleLabel.font = [UIFont boldSystemFontOfSize:15.0];
    printButton1.frame = CGRectMake(0.0, 0.0, 60.0, 45.0);
    printButton = [[UIBarButtonItem alloc]  initWithCustomView:printButton1];
    
    UIButton *emailButton1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [emailButton1 addTarget:self
                    action:@selector(emailView:)
          forControlEvents:UIControlEventTouchUpInside];
    [emailButton1 setTitle:@"Email" forState:UIControlStateNormal];
    emailButton1.frame = CGRectMake(0.0, 0.0, 60.0, 45.0);
    emailButton1.titleLabel.font = [UIFont boldSystemFontOfSize:15.0];
    emailButton = [[UIBarButtonItem alloc]  initWithCustomView:emailButton1];
    
    NSArray *items = [NSArray arrayWithObjects:printButton, emailButton, nil];
    self.navigationItem.rightBarButtonItems = items;
}

- (void) convertViewToFile {
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    
    UIGraphicsBeginImageContext(screenRect.size);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [[UIColor blackColor] set];
    CGContextFillRect(ctx, screenRect);
    
    [self.tableView.layer renderInContext:ctx];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    NSMutableArray *infoArr = [patientInfoArray objectAtIndex:indexPath.section];
    NSMutableDictionary *infoDict = [infoArr objectAtIndex:indexPath.row];
    cell.textLabel.text = [infoDict objectForKey:@"name"];
    cell.detailTextLabel.text = [infoDict objectForKey:@"selectedValue"];
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    NSMutableDictionary *dict1 = [sectionArray objectAtIndex:section];
    return [dict1 objectForKey:@"title"];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSMutableArray *infoArr = [patientInfoArray objectAtIndex:indexPath.section];
    NSMutableDictionary *infoDict = [infoArr objectAtIndex:indexPath.row];
    if ([[infoDict objectForKey:@"control"] isEqualToString:@"TextField"] || [[infoDict objectForKey:@"control"] isEqualToString:@"TextView"]) {
        [self pushEditForm:indexPath.section push:indexPath.row];
    }else if ([[infoDict objectForKey:@"control"] isEqualToString:@"DisclosureIndicator"]) {
        [self pushEditForm1:indexPath.section push:indexPath.row];
    }
    NSLog(@"Row:%d", indexPath.row);
}

- (void) pushEditForm:(NSInteger)section push:(NSInteger)row {
    
    NSMutableArray *infoArr = [patientInfoArray objectAtIndex:section];
    NSMutableDictionary *infoDict = [infoArr objectAtIndex:row];
    EditForm1TableViewController *ev = [self.storyboard instantiateViewControllerWithIdentifier:@"EditForm1TableViewController"];
    ev.titleStr = [infoDict objectForKey:@"name"];
    ev.placeHolderStr = [infoDict objectForKey:@"selectedValue"];
    ev.sectionInt = section;
    ev.rowInt = row;
    ev.controlStr = [infoDict objectForKey:@"control"];
    [self.navigationController pushViewController:ev animated:YES];
}

- (void) pushEditForm1:(NSInteger)section push:(NSInteger)row {
    
    NSMutableArray *infoArr = [patientInfoArray objectAtIndex:section];
    NSMutableDictionary *infoDict = [infoArr objectAtIndex:row];
    SelectTableViewController *sv = [self.storyboard instantiateViewControllerWithIdentifier:@"SelectTableViewController"];
    sv.rowArray = [[infoDict objectForKey:@"selectValue"] componentsSeparatedByString:@","];
    sv.viewTitle = [infoDict objectForKey:@"name"];
    sv.sectionInt = section;
    sv.rowInt = row;
    [self.navigationController pushViewController:sv animated:YES];
}

- (void) printView:(id) sender {
    
    NSData *dataFromPath= UIImageJPEGRepresentation(newImage,0.0);
    
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"Lock" ofType:@"png"];
//    NSData *dataFromPath = [NSData dataWithContentsOfFile:path];
    
    UIPrintInteractionController *printController = [UIPrintInteractionController sharedPrintController];
    
    if(printController && [UIPrintInteractionController canPrintData:dataFromPath]) {
        NSLog(@"Print Form1..!");
        printController.delegate = self;
        
        UIPrintInfo *printInfo = [UIPrintInfo printInfo];
        printInfo.outputType = UIPrintInfoOutputGeneral;
        printInfo.jobName = @"Form1";
        printInfo.duplex = UIPrintInfoDuplexLongEdge;
        printController.printInfo = printInfo;
        printController.showsPageRange = YES;
        printController.printingItem = dataFromPath;
        
        void (^completionHandler)(UIPrintInteractionController *, BOOL, NSError *) = ^(UIPrintInteractionController *printController, BOOL completed, NSError *error) {
            if (!completed && error) {
                NSLog(@"FAILED! due to error in domain %@ with error code %u", error.domain, error.code);
            }
        };
        
//        [printController presentAnimated:YES completionHandler:completionHandler];
        [printController presentFromBarButtonItem:printButton animated:YES completionHandler:completionHandler];
    }
}

- (void) emailView:(id) sender {
    
    NSString *emailTitle = @"Risk Assessment Form 1";
    NSString *messageBody = @"Please check the attachment";
    NSArray *toRecipents = [NSArray arrayWithObject:@"peeyush.shrivastava@sutherlandglobal.com"];
    
    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
    mc.mailComposeDelegate = self;
    [mc setSubject:emailTitle];
    [mc setMessageBody:messageBody isHTML:YES];
    [mc setToRecipients:toRecipents];
    
    NSData *fileData = UIImageJPEGRepresentation(newImage,0.0);
    
    [mc addAttachmentData:fileData mimeType:@"abc" fileName:@"Form1"];
    
    [self presentViewController:mc animated:YES completion:NULL];
    
//    // Email Subject
//    NSString *emailTitle = @"Test Email";
//    // Email Content
//    NSString *messageBody = @"iOS programming is so fun!";
//    // To address
//    NSArray *toRecipents = [NSArray arrayWithObject:@"peeyush.shrivastava@sutherlandglobal.com"];
//    
//    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
//    mc.mailComposeDelegate = self;
//    [mc setSubject:emailTitle];
//    [mc setMessageBody:messageBody isHTML:NO];
//    [mc setToRecipients:toRecipents];
//    
//    // Present mail view controller on screen
//    [self presentViewController:mc animated:YES completion:NULL];

}

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    
    [self dismissViewControllerAnimated:YES completion:NULL];
}

@end
