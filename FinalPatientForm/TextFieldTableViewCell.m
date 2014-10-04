//
//  TextFieldTableViewCell.m
//  FinalPatientForm
//
//  Created by Peeyush on 16/09/14.
//  Copyright (c) 2014 sutherland. All rights reserved.
//

#import "TextFieldTableViewCell.h"
#import "GlobalData.h"

@implementation TextFieldTableViewCell
@synthesize cellTextField, textFieldLabel;

- (void)awakeFromNib
{

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
