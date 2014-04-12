//
//  MouseListViewController.m
//  Mouseville
//
//  Created by shnee on 4/1/14.
//  Copyright (c) 2014 CapstoneProject. All rights reserved.
//

#import "MouseListViewController.h"
#import "Cage.h"

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


-(NSArray*) getCageNames:(RackDetails*) rackDetails
{
    NSMutableArray* cageNames = [[NSMutableArray alloc]init];
    
    for(CageDetails* tmpcage in rackDetails.cages)
    {
        NSString* row = [Cage numberToAlphabet:tmpcage.row_id];
        NSString* column = [NSString stringWithFormat:@"%d",[tmpcage.column_id intValue]];
        NSMutableString* cageName = [[NSMutableString alloc]init];
        [cageName appendString:row];
        [cageName appendString:column];
        
        [cageNames addObject:[NSString stringWithString:cageName]];
        
        
    }
    
    return [cageNames sortedArrayUsingSelector:@selector(localizedStandardCompare:)];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
        
    self.miceArray = [self.mice allObjects];
    
    MouseDetails *tmpmouse = self.miceArray[0];
    
    NSArray *cageNames = [self getCageNames:tmpmouse.cageDetails.rackDetails];
    
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
