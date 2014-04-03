//
//  SearchMouseViewController.m
//  Mouseville
//
//  Created by Abhang Sonawane on 3/29/14.
//  Copyright (c) 2014 CapstoneProject. All rights reserved.
//

#import "SearchMouseViewController.h"
#import "PopOverViewController.h"
@interface SearchMouseViewController ()
{
    UIPopoverController *popoverController;
    PopOverViewController *popoverView;
    
}
@end

@implementation SearchMouseViewController

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
    popoverView = [[UIStoryboard storyboardWithName:@"Storyboard" bundle:nil]instantiateViewControllerWithIdentifier:@"dropdown"];
    [popoverView setArrData:arr];
    popoverView.delegate = self;
    popoverController = [[UIPopoverController alloc]initWithContentViewController:popoverView];
    [popoverView setIdentifier:@"searchMouseGenotypePopover"];

    
    
}

/*-(void)didClickDropdown:(NSString *)string{
    
    NSLog(@"Selected:%@",string);
    [popoverController dismissPopoverAnimated:YES];
    
}*/

-(void) didClickDropdown:(NSString *)string popoverIdentifier:(NSString *)popoverIdentifier
{
    NSLog(@"Selected:%@",string);
    [popoverController dismissPopoverAnimated:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)sliderValueChanged:(id)sender {
    
    self.label1.text= [NSString stringWithFormat:@"%.0f", self.slider.value];
    self.slider.maximumValue= 36;
    self.slider.minimumValue=3;
    
    if(self.slider.value == 0)
    {
        UIAlertView *alert= [[UIAlertView alloc]initWithTitle:@"0!" message:@"Mice with age 0 will be those born today." delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil, nil];
        [alert show];
    }
    
}
- (IBAction)chooseGenotype:(id)sender {
     [popoverController presentPopoverFromRect:[sender frame] inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}
@end
