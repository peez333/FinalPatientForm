//
//  SelectTableViewController.h
//  FinalPatientForm
//
//  Created by Peeyush on 08/09/14.
//  Copyright (c) 2014 sutherland. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectTableViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, retain) NSArray *rowArray;
@property(nonatomic, retain) NSString *viewTitle;
@property(nonatomic) NSInteger sectionInt;
@property(nonatomic) NSInteger rowInt;

@end
