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

-(NSManagedObjectContext*) managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication]delegate];
    if([delegate performSelector:@selector(managedObjectContext)])
    {
        context = [delegate managedObjectContext];
    }
    
    return context;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.currentCage.mouseDetails count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mouse"];
    
    UILabel *mouseName = (UILabel *)[cell viewWithTag:132];
    MouseDetails *mouse = [self.miceArray objectAtIndex:indexPath.row];
    
    mouseName.text = mouse.mouse_name;
            
    UILabel *mouseDesc = (UILabel *)[cell viewWithTag:133];
    NSDateFormatter *date = [[NSDateFormatter alloc] init];
    [date setDateFormat:@"yyyy.MM.dd"];
    NSString *genotype_str = [Mouse getGenotypeString:mouse];
    mouseDesc.text = [NSString stringWithFormat:@"%@ / %@",
                      ([genotype_str length] > 0) ? genotype_str : @"No Genotype Info",
                      [date stringFromDate:mouse.birth_date]];
    
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
    if (![self.currentCageIndex isEqualToString:[Cage getStringFromIndex:self.currentCage]]) {
        Cage *cage_helper = [[Cage alloc] init];
        NSManagedObjectContext *context = [self managedObjectContext];
        
        NSNumber *column = [Cage alphabetToNumber:[self.currentCageIndex substringToIndex:1]];
        NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
        [f setNumberStyle:NSNumberFormatterDecimalStyle];
        NSNumber *row = [f numberFromString:[self.currentCageIndex substringFromIndex:1]];
        
        [cage_helper moveMouseToDifferentCage:context rack:self.currentCage.rackDetails cageDetails:self.currentCage mouseDetails:self.selectedMouse rowToMove:row columnToMove:column];
        
    }
}

-(void)didClickDropdown:(NSString *)string popoverIdentifier:(NSString *)popoverIdentifier {
    self.currentCageIndex = string;
}

- (IBAction)chooseCage:(id)sender {
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:buttonPosition];
    self.selectedMouse = [self.miceArray objectAtIndex:indexPath.row];
    
    NSLog(@"Mouse selected: %@", self.selectedMouse.mouse_name);
    
    [popoverController presentPopoverFromRect:[sender frame] inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}


-(NSArray*) getCageNamesWithoutCurrentCage:(CageDetails *)cage
{
    NSMutableArray* cageNames = [[NSMutableArray alloc]init];
    
    for(CageDetails* tmpcage in cage.rackDetails.cages)
    {
        // if we're on the current cage continue to the net one
        if(cage.cage_id.intValue == tmpcage.cage_id.intValue) {
            continue;
        }
        
        NSString* row = [Cage numberToAlphabet:tmpcage.row_id];
        NSString* column = [NSString stringWithFormat:@"%d",[tmpcage.column_id intValue]];
        NSMutableString* cageName = [[NSMutableString alloc]init];
        [cageName appendString:row];
        [cageName appendString:column];
        
        
        [cageNames addObject:[NSString stringWithString:cageName]];
        
        
    }
    
    return [cageNames sortedArrayUsingSelector:@selector(localizedStandardCompare:)];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.selectedMouse = [self.miceArray objectAtIndex:indexPath.row];
    NSLog(@"Mouse selected at index %d with name %@", indexPath.row, self.selectedMouse.mouse_name);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.selectedMouse = nil;
    self.miceArray = [self.currentCage.mouseDetails allObjects];
    
    //MouseDetails *tmpmouse = self.miceArray[0];
    //self.currentCage = tmpmouse.cageDetails;
    
    self.currentCageIndex = [Cage getStringFromIndex:self.currentCage];
    
    NSMutableArray *cageNames = [[self getCageNamesWithoutCurrentCage:self.currentCage] mutableCopy];
    
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
