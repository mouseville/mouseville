//
//  CreateMouseViewController.h
//  Mouseville
//
//  Created by Abhang Sonawane on 3/25/14.
//  Copyright (c) 2014 CapstoneProject. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CreateMouseViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *headingLabel;
@property (weak, nonatomic) IBOutlet UILabel *genotypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateOfBirthLabel;
@property (weak, nonatomic) IBOutlet UILabel *rackLabel;
@property (weak, nonatomic) IBOutlet UILabel *cageLabel;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *genderLabel;
@property (weak, nonatomic) IBOutlet UITextField *dateOfBirthText;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *cancelButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *addDateButton;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UISegmentedControl *gender;
@property (weak, nonatomic) IBOutlet UIView *DatePickerView;

- (IBAction)createMouse:(id)sender;

-(IBAction)cancelMouse:(id)sender;
- (IBAction)selectDate:(id)sender;
- (IBAction)changeSelectedDate:(id)sender;
- (IBAction)genderChanged:(id)sender;
- (IBAction)showDatePicker:(id)sender;
@end
