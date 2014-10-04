//
//  TextFieldTableViewCell.h
//  FinalPatientForm
//
//  Created by Peeyush on 16/09/14.
//  Copyright (c) 2014 sutherland. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TextFieldTableViewCell : UITableViewCell <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel *textFieldLabel;
@property (weak, nonatomic) IBOutlet UITextField *cellTextField;

@end
