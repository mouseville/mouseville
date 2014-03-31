//
//  MouseViewController.h
//  Mouseville
//
//  Created by Abhang Sonawane on 3/25/14.
//  Copyright (c) 2014 CapstoneProject. All rights reserved.
//

#import <UIKit/UIKit.h>
#import  "PopOverViewController.h"
#import "DatePickerViewController.h"

@interface MouseViewController : UIViewController<DropDownDelegate, DatePickerDelegate>
@property (weak, nonatomic) IBOutlet UIButton *showButton;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *selectDateButton;


@property (weak, nonatomic) IBOutlet UITextField *dateOfBirthText;

- (IBAction)chooseGenotype:(id)sender;

- (IBAction)selectDate:(id)sender;
- (IBAction)showDatePicker:(id)sender;

@end
