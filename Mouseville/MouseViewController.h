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

@property (weak, nonatomic) IBOutlet UIButton *btnChooseGenotype;

@property (weak, nonatomic) IBOutlet UITextField *dateOfBirthText;

- (IBAction)chooseGenotype:(id)sender;

- (IBAction)selectDate:(id)sender;
- (IBAction)showDatePicker:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnSelectRack;
@property (weak, nonatomic) IBOutlet UIButton *btnSelectCage;

@property (assign, nonatomic) NSString* rackName;
@property (assign, nonatomic) NSString* cageName;
@property  NSMutableArray* genotypeMutableArray;

- (IBAction)selectRack:(id)sender;


- (IBAction)selectCage:(id)sender;
@end
