//
//  CreateMouseViewController.m
//  Mouseville
//
//  Created by Abhang Sonawane on 3/25/14.
//  Copyright (c) 2014 CapstoneProject. All rights reserved.
//

#import "CreateMouseViewController.h"

@interface CreateMouseViewController ()


@end

@implementation CreateMouseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    //self.datePicker=  [[UIDatePicker alloc] init];
    
    self.datePicker.datePickerMode = UIDatePickerModeDate;
   
    
    // [self.datePicker addTarget:self action:@selector(datePickerDateChanged:)
           //     forControlEvents:UIControlEventValueChanged];
    
    
     NSDate *todayDate = [NSDate date];
     self.datePicker.maximumDate = todayDate;
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)createMouse:(id)sender {
}

- (IBAction)cancelMouse:(id)sender {
}
- (IBAction)selectDate:(id)sender {
    //done button on the datepicker view
    
    
    NSDate *currentDate = self.datePicker.date;
    
    self.dateOfBirthText.text = [[NSString alloc]initWithFormat:@"%@", currentDate];
    
    //  self.DatePickerView.hidden = YES;
    
    //NSLog(@"Date = %@", currentDate);
    
    
    
}
- (IBAction)changeSelectedDate:(id)sender {
    
    //datepicker action
    
    
}
- (IBAction)genderChanged:(id)sender {
}

- (IBAction)showDatePicker:(id)sender {
    
   // self.DatePickerView.hidden = NO;
    
    
}
@end
