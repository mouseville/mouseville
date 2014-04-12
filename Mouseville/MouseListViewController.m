//
//  MouseListViewController.m
//  Mouseville
//
//  Created by shnee on 4/1/14.
//  Copyright (c) 2014 CapstoneProject. All rights reserved.
//

#import "MouseListViewController.h"

@interface MouseListViewController ()
{
    UIPopoverController *popoverController;
    PopOverViewController *popoverView;
}

@end

@implementation MouseListViewController

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.mice count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mouse"];
    
    UILabel *mouseName = (UILabel *)[cell viewWithTag:132];
    MouseDetails *mouse = [self.miceArray objectAtIndex:indexPath.row];
    
    mouseName.text = mouse.mouse_name;
            
    UILabel *mouseDesc = (UILabel *)[cell viewWithTag:133];
    NSDateFormatter *date = [[NSDateFormatter alloc] init];
    [date setDateFormat:@"yyyy.MM.dd"];
    mouseDesc.text = [NSString stringWithFormat:@"%@ / %@", @"Genotype", [date stringFromDate:mouse.birth_date]];
    
    return cell;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)didDeSelectClickDropdown:(NSString *)string popoverIdentifier:(NSString *)popoverIdentifier {
    
}

-(void)dropDownWillDisappear:(NSString *)popoverIdentifier {
    
}

-(void)didClickDropdown:(NSString *)string popoverIdentifier:(NSString *)popoverIdentifier {
    
}

- (IBAction)chooseCage:(id)sender {
    [popoverController presentPopoverFromRect:[sender frame] inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
        
    self.miceArray = [self.mice allObjects];
    
    NSArray *cageNames = [NSArray arrayWithObjects:@"Cage A1", @"Cage A2", nil];
    
    popoverView = [[UIStoryboard storyboardWithName:@"Storyboard" bundle:nil] instantiateViewControllerWithIdentifier:@"dropdown"];
    
    [popoverView setArrData:cageNames];
    popoverView.delegate = self;
    popoverController = [[UIPopoverController alloc] initWithContentViewController:popoverView];
    [popoverView setIdentifier:@"cageNamesPopover"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
