//
//  EditForm1TableViewController.h
//  FinalPatientForm
//
//  Created by Peeyush on 11/09/14.
//  Copyright (c) 2014 sutherland. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditForm1TableViewController : UITableViewController <UITextFieldDelegate,UITextViewDelegate>

@property(nonatomic,retain)NSString *titleStr;
@property(nonatomic,retain)NSString *placeHolderStr;
@property(nonatomic,retain)NSString *controlStr;
@property(nonatomic)NSInteger sectionInt;
@property(nonatomic)NSInteger rowInt;

@end
