//
//  MouseViewController.m
//  Mouseville
//
//  Created by Abhang Sonawane on 3/25/14.
//  Copyright (c) 2014 CapstoneProject. All rights reserved.
//

#import "MouseViewController.h"
#import "PopOverViewController.h"
#import "DatePickerViewController.h"


@interface MouseViewController ()
{
    UIPopoverController *popoverController;
    PopOverViewController *popoverView;
    
    UIPopoverController *datePickerController;
    DatePickerViewController *datePickerView;
    
}
@end

@implementation MouseViewController

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

 
    NSArray *arr =[NSArray arrayWithObjects:@"A:1",@"A:2", nil];
    popoverView = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"dropdown"];
    [popoverView setArrData:arr];
        popoverController = [[UIPopoverController alloc]initWithContentViewController:popoverView];
    
    datePickerView=[[UIStoryboard storyboardWithName:@"Storyboard" bundle:nil]instantiateViewControllerWithIdentifier:@"datepicker"];
    datePickerController= [[UIPopoverController alloc]initWithContentViewController:datePickerView];
    
    

}

-(void)didClickDropdown:(NSString *)string{
    
    NSLog(@"Selected:%@",string);
    [popoverController dismissPopoverAnimated:YES];
    
}

-(void) didClickDatePicker:(NSString *)string{

    self.dateOfBirthText.text = string;
    [datePickerController dismissPopoverAnimated:YES];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)showDatePicker:(id)sender {
    
    [datePickerController presentPopoverFromRect:[sender frame] inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];

    

}
- (IBAction)chooseGenotype:(id)sender {
    
    [popoverController presentPopoverFromRect:[sender frame] inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];

}

- (IBAction)selectDate:(id)sender {
    
    
   // NSDate *currentDate = self.datePicker.date;
    
   // self.dateOfBirthText.text = [[NSString alloc]initWithFormat:@"%@", currentDate];
  //    self.DatePickerView.hidden = YES;
}
@end
