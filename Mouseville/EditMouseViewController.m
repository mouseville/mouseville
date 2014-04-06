//
//  EditMouseViewController.m
//  Mouseville
//
//  Created by Abhang Sonawane on 4/5/14.
//  Copyright (c) 2014 CapstoneProject. All rights reserved.
//

#import "EditMouseViewController.h"

@interface EditMouseViewController ()

@end

@implementation EditMouseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (IBAction)btnDateClick:(id)sender {
    
    UIViewController* popoverContent = [[UIViewController alloc] init]; //ViewController
    
    UIView *popoverDateView = [[UIView alloc] init];   //view
    //popoverDateView.backgroundColor = [UIColor blackColor];
    
    //Date picker
    UIDatePicker *datePicker=[[UIDatePicker alloc]init];
    datePicker.frame=CGRectMake(0,44,320, 216);
    datePicker.datePickerMode = UIDatePickerModeDateAndTime;
    [datePicker setMinuteInterval:5];
    [datePicker setTag:10];
    datePicker.datePickerMode = UIDatePickerModeDate;
    datePicker.maximumDate = [NSDate date];
    [datePicker addTarget:self action:@selector(result:) forControlEvents:UIControlEventValueChanged];
    [popoverDateView addSubview:datePicker];
    
    //    if(self..text.length>0)
    //    {
    //        @try {
    //            NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
    //            [formatter setDateFormat:@"MM/dd/yyyy"];
    //            NSDate * dateToSet = [formatter dateFromString:self.dateOfBirthText.text];
    //            datePicker.date = dateToSet;
    //        }
    //        @catch (NSException *exception) {
    //
    //            datePicker.date = [NSDate date];
    //
    //        }
    //    }
    
    
    popoverContent.view = popoverDateView;
    UIPopoverController*  popoverDateController = [[UIPopoverController alloc] initWithContentViewController:popoverContent];
    popoverDateController.delegate=self;
    
    [popoverDateController setPopoverContentSize:CGSizeMake(320, 264) animated:NO];
    [popoverDateController presentPopoverFromRect:[[self btnDate] frame] inView:self.view permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];//tempButton.frame where you need you can put that frame
    
    
}


-(void) result: (id)sender
{
    NSDate* dateSelected = ((UIDatePicker*)sender).date;
    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"MM/dd/yyyy"];
    //self.dateOfBirthText.text = [formatter stringFromDate:dateSelected];
    self.lblDate.text = [formatter stringFromDate:dateSelected];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
