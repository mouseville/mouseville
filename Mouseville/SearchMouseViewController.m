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
    NSDictionary *racklist;
    NSArray *rackSectionTitles;
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


    racklist = @{@"Rack 1" : @[@"Mouse 1A", @"Mouse 2A", @"Mouse 3A", @"Mouse 4A"],
                 @"Rack 2" : @[@"Mouse 1B", @"Mouse 2B", @"Mouse 3B", @"Mouse 4B"],
                 @"Rack 3" : @[@"Mouse 1C", @"Mouse 2C", @"Mouse 3C", @"Mouse 4C"],
                 @"Rack 4" : @[@"Mouse 1D", @"Mouse 2D", @"Mouse 3D", @"Mouse 4D"]};
    
    rackSectionTitles = [[racklist allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSString *sectionTitle = [rackSectionTitles objectAtIndex:section];
    NSArray *sectionRacks = [racklist objectForKey:sectionTitle];
    return [sectionRacks count];
}

- (NSInteger)numberofSectionsInTableView:(UITableView *)tableView {
    return [rackSectionTitles count];
}

- (NSArray *)sectionIndexTilesForTableView:(UITableView *)tableView {
    return rackSectionTitles;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    NSString *sectionTitle = [rackSectionTitles objectAtIndex:indexPath.section];
    NSArray *sectionRacks = [racklist objectForKey:sectionTitle];
    NSString *rack = [sectionRacks objectAtIndex:indexPath.row];
    cell.textLabel.text = rack;
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [rackSectionTitles objectAtIndex:section];
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
