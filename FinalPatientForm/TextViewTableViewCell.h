//
//  TextViewTableViewCell.h
//  FinalPatientForm
//
//  Created by Peeyush on 16/09/14.
//  Copyright (c) 2014 sutherland. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TextViewTableViewCell : UITableViewCell <UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *textViewLabel;
@property (weak, nonatomic) IBOutlet UITextView *cellTextView;

@end
