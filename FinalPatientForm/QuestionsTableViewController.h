//
//  QuestionsTableViewController.h
//  FinalPatientForm
//
//  Created by Peeyush on 22/09/14.
//  Copyright (c) 2014 sutherland. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuestionsTableViewController : UITableViewController <UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, retain) NSMutableArray *rowArray;
@property(nonatomic) NSInteger sectionInt;
@property(nonatomic) NSInteger rowInt;

@end
