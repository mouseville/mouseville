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
#import "Rack.h"
#import "Cage.h"
#import "RackDetails.h"


@interface MouseViewController ()
{
    UIPopoverController *popoverController;
    PopOverViewController *popoverView;
    
    UIPopoverController *datePickerController;
    DatePickerViewController *datePickerView;
    
    UIPopoverController *rackPopoverController;
    PopOverViewController *rackPopoverViewController;
    
    UIPopoverController *cagePopoverController;
    PopOverViewController *cagePopoverViewController;
    
    
    
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
    
    self.genotypeMutableArray = [[NSMutableArray alloc]init];
    
    Rack *rack = [[Rack alloc]init];
    
    NSArray* racks = [rack getAllRacks:[self managedObjectContext]];
    
    NSMutableArray* rackNames = [[NSMutableArray alloc]init];
    
    for (RackDetails *individualRack in racks)
    {
        [rackNames addObject:individualRack.rack_name];
    }
    
    
    rackPopoverViewController = [[UIStoryboard storyboardWithName:@"Storyboard" bundle:nil]instantiateViewControllerWithIdentifier:@"dropdown"];
    
    [rackPopoverViewController setArrData:[NSArray arrayWithArray:rackNames]];
    
    
    rackPopoverController = [[UIPopoverController alloc]initWithContentViewController:rackPopoverViewController];
    
    [rackPopoverViewController setIdentifier:@"rackDropDown"];
    
      
    cagePopoverViewController = [[UIStoryboard storyboardWithName:@"Storyboard" bundle:nil]instantiateViewControllerWithIdentifier:@"dropdown"];
    
    cagePopoverController = [[UIPopoverController alloc] initWithContentViewController:cagePopoverViewController];
    
    [cagePopoverViewController setIdentifier:@"cageDropDown"];
    
    rackPopoverViewController.delegate = self;
    cagePopoverViewController.delegate = self;
    
    
    NSArray *arr =[NSArray arrayWithObjects:@"A:1",@"A:2", nil];
    popoverView = [[UIStoryboard storyboardWithName:@"Storyboard" bundle:nil]instantiateViewControllerWithIdentifier:@"dropdown"];
    [popoverView setArrData:arr];
        popoverController = [[UIPopoverController alloc]initWithContentViewController:popoverView];
    popoverView.delegate = self;
    [popoverView setIdentifier:@"genotypeDropDown"];
    popoverView.tableView.allowsMultipleSelection = YES;
    
    
    datePickerView=[[UIStoryboard storyboardWithName:@"Storyboard" bundle:nil]instantiateViewControllerWithIdentifier:@"datepicker"];
    datePickerController= [[UIPopoverController alloc]initWithContentViewController:datePickerView];
    
    

}


-(NSArray*) getCageNames:(RackDetails*) rackDetails
{
    NSMutableArray* cageNames = [[NSMutableArray alloc]init];
    
    for(CageDetails* cage in rackDetails.cages)
    {
        NSString* row = [self numberToAlphabet:cage.row_id];
        NSString* column = [NSString stringWithFormat:@"%d",[cage.column_id intValue]];
        NSMutableString* cageName = [[NSMutableString alloc]init];
        [cageName appendString:row];
        [cageName appendString:column];
        
        [cageNames addObject:[NSString stringWithString:cageName]];
        
        
    }
    
    return [cageNames sortedArrayUsingSelector:@selector(localizedStandardCompare:)];
}


-(NSString*) numberToAlphabet: (NSNumber* )number
{
    
    NSString* allAlphabets =  @"A,B,C,D,E,F,G,H,I,J";
    
    NSArray* alphabetArray = [[NSArray alloc]initWithArray:[allAlphabets componentsSeparatedByString:@","]];
    
    return [alphabetArray objectAtIndex:([number intValue]-1)];
    
}




/*
-(void)didClickDropdown:(NSString *)string{
    
    if([ popoverView.identifier isEqual:@"genotypeDropDown"])
         NSLog(@"Selected:%@",string);
    [popoverController dismissPopoverAnimated:YES];
}*/

-(void)didClickDropdown:(NSString *)string popoverIdentifier:(NSString *)popoverIdentifier
{
   
    if([popoverIdentifier isEqual:@"genotypeDropDown"])
    {
        /*UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"rack" message:string delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [popoverController dismissPopoverAnimated:YES];
        */
        
       //[[self btnChooseGenotype] setTitle:string forState:UIControlStateNormal];
       //[popoverController dismissPopoverAnimated:YES];
        [self.genotypeMutableArray addObject:string];
        
    }
    
    if([popoverIdentifier isEqual:@"rackDropDown"])
    {
        [[self btnSelectRack]setTitle:string forState:UIControlStateNormal];
        [self setRackName:string];
        [self resetCageButton];
        [rackPopoverController dismissPopoverAnimated:YES];
    }
    
    if([popoverIdentifier isEqual:@"cageDropDown" ])
    {
        [[self btnSelectCage]setTitle:string forState:UIControlStateNormal ];
        [self setCageName:string];
        [cagePopoverController dismissPopoverAnimated:YES];
    }
    
}

-(void)didDeSelectClickDropdown:(NSString *)string popoverIdentifier:(NSString *)popoverIdentifier
{
    
    if([popoverIdentifier isEqual:@"genotypeDropDown"])
    {
        [self.genotypeMutableArray removeObject:string];
    }
}

-(void)dropDownWillDisappear:(NSString *)popoverIdentifier
{
    if([popoverIdentifier isEqual:@"genotypeDropDown"])
    {
        if([self.genotypeMutableArray count]!=0)
        [[self btnChooseGenotype]setTitle:[self.genotypeMutableArray componentsJoinedByString:@","]forState:UIControlStateNormal];
        else
            [[self btnChooseGenotype]setTitle:@"Choose Genotype" forState:UIControlStateNormal];
    }
}


-(void) resetCageButton
{
    Rack* rack = [[Rack alloc]init];
    RackDetails* rackDetail = [rack getParticularRack:[self managedObjectContext] rackName:[self rackName]];
    
    cagePopoverViewController = [[UIStoryboard storyboardWithName:@"Storyboard" bundle:nil]instantiateViewControllerWithIdentifier:@"dropdown"];
    
    cagePopoverController = [[UIPopoverController alloc] initWithContentViewController:cagePopoverViewController];
    
    [cagePopoverViewController setIdentifier:@"cageDropDown"];
    
    [cagePopoverViewController setArrData:[self getCageNames:rackDetail]];
    
    cagePopoverViewController.delegate = self;
    
    [[self btnSelectCage]setTitle:@"select cage" forState:UIControlStateNormal];
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

-(NSManagedObjectContext*) managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication]delegate];
    if([delegate performSelector:@selector(managedObjectContext)])
    {
        context = [delegate managedObjectContext];
    }
    
    return context;
}




- (IBAction)selectDate:(id)sender {
    
    
   // NSDate *currentDate = self.datePicker.date;
    
   // self.dateOfBirthText.text = [[NSString alloc]initWithFormat:@"%@", currentDate];
  //    self.DatePickerView.hidden = YES;
}
- (IBAction)selectRack:(id)sender {
    [rackPopoverController presentPopoverFromRect:[sender frame] inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    
    
}

- (IBAction)selectCage:(id)sender {
    
    [cagePopoverController presentPopoverFromRect:[sender frame] inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}
@end
