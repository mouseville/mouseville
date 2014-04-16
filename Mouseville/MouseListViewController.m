//
//  MouseListViewController.m
//  Mouseville
//
//  Created by shnee on 4/1/14.
//  Copyright (c) 2014 CapstoneProject. All rights reserved.
//

#import "MouseListViewController.h"
#import "Cage.h"
#import "MouseViewController.h"
#import "EditMouseViewController.h"

@interface MouseListViewController ()
{
    UIPopoverController *popoverController;
    PopOverViewController *popoverView;
}

@end

@implementation MouseListViewController

- (IBAction)addMouse:(id)sender {
    MouseViewController *viewController = [[UIStoryboard storyboardWithName:@"Storyboard" bundle:nil] instantiateViewControllerWithIdentifier:@"mouseController"];
    viewController.modalPresentationStyle = UIModalPresentationFormSheet;
    viewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:viewController animated:YES completion:^{viewController.view.superview.frame = CGRectMake(0, 0, 700, 933);
        viewController.view.superview.center = self.view.superview.superview.center;
    }];
    self.miceArray = [self.currentCage.mouseDetails allObjects];
    [self.tableView reloadData];
}

-(NSManagedObjectContext*) managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication]delegate];
    if([delegate performSelector:@selector(managedObjectContext)])
    {
        context = [delegate managedObjectContext];
    }
    
    return context;
}

- (IBAction)editMouse:(id)sender {
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:buttonPosition];
    self.selectedMouse = [self.miceArray objectAtIndex:indexPath.row];
    
    
    EditMouseViewController *viewController = [[UIStoryboard storyboardWithName:@"Storyboard" bundle:nil] instantiateViewControllerWithIdentifier:@"editMouseController"];
    viewController.modalPresentationStyle = UIModalPresentationFormSheet;
    viewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
    viewController.mouse = self.selectedMouse;
    
    [self presentViewController:viewController animated:YES completion:^{viewController.view.superview.frame = CGRectMake(0, 0, 700, 933);
        viewController.view.superview.center = self.view.superview.superview.center;
    }];
    
    [self.tableView reloadData];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.miceArray count];
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
        
        CageDetails *destCage = [cage_helper getParticularCage:context rack:self.currentCage.rackDetails row:row column:column];
        
        // make sure we will not have 2 males in the same cage
        int destCageStatus = [Cage getBreedingStatus:destCage ];
        if ([self.selectedMouse.gender isEqualToString:@"Male"] && ((destCageStatus == BREEDING) || destCageStatus == MALE_ONLY)) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"You attempted to move a male into a cage that already containts a male. This is not allowed." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alert show];
        } else {
        
            // check is this move will make the destination cage a breeding cage
            if (([self.selectedMouse.gender isEqualToString:@"Male"] && (destCageStatus == FEMALE_ONLY)) ||
                ([self.selectedMouse.gender isEqualToString:@"Female"] && (destCageStatus == MALE_ONLY))) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"The destination age has been marked a breeding cage." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
            }
            
            [cage_helper moveMouseToDifferentCage:context rack:self.currentCage.rackDetails cageDetails:self.currentCage mouseDetails:self.selectedMouse rowToMove:row columnToMove:column];
                
            self.miceArray = [self.currentCage.mouseDetails allObjects];
                
            [self.tableView reloadData];
        }
    }
}

-(void)didClickDropdown:(NSString *)string popoverIdentifier:(NSString *)popoverIdentifier {
    self.currentCageIndex = string;
    [popoverController dismissPopoverAnimated:YES];
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
        
        NSString* column = [Cage numberToAlphabet:tmpcage.column_id];
        NSString* row = [NSString stringWithFormat:@"%d",[tmpcage.row_id intValue]];
        NSMutableString* cageName = [[NSMutableString alloc]init];
        [cageName appendString:column];
        [cageName appendString:row];
        
        
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
