//
//  DatePickerViewController.m
//  Mouseville
//
//  Created by Abhang Sonawane on 3/31/14.
//  Copyright (c) 2014 CapstoneProject. All rights reserved.
//

#import "DatePickerViewController.h"

@interface DatePickerViewController ()

@end

@implementation DatePickerViewController

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
    
    
    self.datePicker.datePickerMode = UIDatePickerModeDate;
    
    NSDate *todayDate = [NSDate date];
    self.datePicker.maximumDate = todayDate;
    
    
    
   }

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)datePicked:(UIDatePicker *)sender {
    
    
    NSDate *currentDate = self.datePicker.date;   
    
    [self.delegate didClickDatePick:[[NSString alloc]initWithFormat:@"%@", currentDate]];
}



@end
