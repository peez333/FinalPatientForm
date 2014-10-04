//
//  SelectForm2TableViewController.h
//  FinalPatientForm
//
//  Created by Peeyush on 23/09/14.
//  Copyright (c) 2014 sutherland. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectForm2TableViewController : UITableViewController<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, retain) NSArray *rowArray;
@property(nonatomic, retain) NSString *viewTitle;
@property(nonatomic, retain) NSString *userSelectStr;
@property(nonatomic) NSInteger sectionInt;
@property(nonatomic) NSInteger rowInt;

@end
