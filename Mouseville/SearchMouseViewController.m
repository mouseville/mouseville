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
{
    NSArray *racklist;
}

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
    
    
    self.genotypeMutableArray = [[NSMutableArray alloc]init];
    
    self.slider.maximumValue= 100;
    self.slider.minimumValue=0;
    
    self.slider2.maximumValue=100;
    self.slider2.minimumValue=0;


    racklist = [NSArray arrayWithObjects:@"Apples",@"Oranges",@"Kiwis",@"Popcorn",nil];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [racklist count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *tableIdentifier = @"tableCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableIdentifier];
    }
    
    cell.textLabel.text = [racklist objectAtIndex:indexPath.row];
    return cell;
}

-(void)didDeSelectClickDropdown:(NSString *)string popoverIdentifier:(NSString *)popoverIdentifier
{
    
}

-(void)dropDownWillDisappear:(NSString *)popoverIdentifier
{
    
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
    
    if(self.slider.value>self.slider2.value)
    {
        self.slider2.value=self.slider.value;
    }
    
    self.label1.text =[NSString stringWithFormat:@"%.0f to %.0f weeks", self.slider.value, self.slider2.value];
    
    
    
    
    
    /*
    if(self.slider.value == 0)
    {
        UIAlertView *alert= [[UIAlertView alloc]initWithTitle:@"0!" message:@"Mice with age 0 will be those born today." delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil, nil];
        [alert show];
    }
    */
    
   
   //  self.label1.text= [NSString stringWithFormat:@"%.0f", self.slider.value];
    
}


- (IBAction)chooseGenotype:(id)sender {
     [popoverController presentPopoverFromRect:[sender frame] inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}
- (IBAction)slider2ValueChanged:(id)sender {
    
    
    if(self.slider.value>self.slider2.value)
    {
        self.slider.value=self.slider2.value;
    }
    
    self.label1.text =[NSString stringWithFormat:@"%.0f to %.0f weeks", self.slider.value, self.slider2.value];
    
    
}
@end
