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
#import "Mouse.h"
#import "GenotypeManager.h"

@interface MouseViewController ()
{
    UIPopoverController *popoverController;
    PopOverViewController *popoverView;
    
    UIPopoverController *rackPopoverController;
    PopOverViewController *rackPopoverViewController;
    
    UIPopoverController *cagePopoverController;
    PopOverViewController *cagePopoverViewController;
    
    UIPopoverController* popoverDateController;
    
    
    
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
    [self.btnCreateMouse setEnabled:YES];
   
    
    /*
    
    [self.createMouseView.layer setCornerRadius:30.0f];
    [self.createMouseView.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [self.createMouseView.layer setBorderWidth:1.5f];
    */
    
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
    
    
    GenotypeManager* genotypeManager = [[GenotypeManager alloc]init];
    
    
    
    NSArray *allGenotypeLabels =[genotypeManager getAllgenotypes:[self managedObjectContext]];
    
    
    
    if([racks count]==0 && [allGenotypeLabels count]==0)
    {
        [self.btnCreateMouse setEnabled:NO];
        UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"Warning" message:@"No racks or genes found! Please create a rack and genes before creating a mouse." delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles: nil];
        [alert show];
        
    }
    
    else if([racks count]==0)
    {
        [self.btnCreateMouse setEnabled:NO];
        UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"Warning" message:@"No racks found! Please create a rack before creating a mouse." delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles: nil];
        [alert show];
        
    }

    
    else if([allGenotypeLabels count]==0)
    {
        [self.btnCreateMouse setEnabled:NO];
        UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"Warning" message:@"No genes found! Please create genes before creating a mouse." delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles: nil];
        [alert show];
        
    }

    
    
    NSMutableArray* arr = [[NSMutableArray alloc]init];
    
    for(GenotypeLabels* individualGenotypeLable in allGenotypeLabels)
    {
        [arr addObject:individualGenotypeLable.genotypeLabel];
    }
    
    
    popoverView = [[UIStoryboard storyboardWithName:@"Storyboard" bundle:nil]instantiateViewControllerWithIdentifier:@"dropdown"];
    [popoverView setArrData:arr];
        popoverController = [[UIPopoverController alloc]initWithContentViewController:popoverView];
    popoverView.delegate = self;
    [popoverView setIdentifier:@"genotypeDropDown"];
    popoverView.tableView.allowsMultipleSelection = YES;
    

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

-(NSNumber*) alphabetToNumber: (NSString*) alphabet
{
 
    
    NSString* allAlphabets =  @"A,B,C,D,E,F,G,H,I,J";
    
    NSArray* alphabetArray = [[NSArray alloc]initWithArray:[allAlphabets componentsSeparatedByString:@","]];
    
    NSUInteger index = [alphabetArray indexOfObject:alphabet]+1;
    
    return [NSNumber numberWithInteger:index];
    
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
        [[self btnChooseGenotype]setTitle:[[self.genotypeMutableArray sortedArrayUsingSelector:@selector(localizedStandardCompare:)]componentsJoinedByString:@","] forState:UIControlStateNormal];
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
    
    [[self btnSelectCage]setTitle:@"Select Cage" forState:UIControlStateNormal];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    popoverDateController = [[UIPopoverController alloc] initWithContentViewController:popoverContent];
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



- (IBAction)btnDoneClick:(id)sender {
    
    if(![self sanityCheck])
    {
        UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Unable to insert mouse details. Please ensure that all the values on this page are set" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
        return;
    }
    
    NSNumberFormatter* numberFormatter = [[NSNumberFormatter alloc]init];
    [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    NSMutableArray* tempMutableArray = [[NSMutableArray alloc]init];
    
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"MM/dd/yyyy"];
    
    [self.btnSelectCage.currentTitle enumerateSubstringsInRange:NSMakeRange(0, self.btnSelectCage.currentTitle.length) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
        [tempMutableArray addObject:substring];
    }];

    NSNumber* cageRow = [self alphabetToNumber:[tempMutableArray objectAtIndex:0 ]];
    NSInteger cageColumnInteger = [[tempMutableArray objectAtIndex:1]intValue];
    NSNumber* cageColumn = [NSNumber numberWithInteger:cageColumnInteger];
    
    NSString* rackName = self.btnSelectRack.currentTitle;
    NSString* mouseName = self.txtMouseName.text;
    NSString* gender = [self.segGenderControl titleForSegmentAtIndex:self.segGenderControl.selectedSegmentIndex];
    NSDate* dateOfBirth = [dateFormatter dateFromString:self.lblDate.text];
    
    NSSet* genotypes = [NSSet setWithArray:[self.btnChooseGenotype.currentTitle componentsSeparatedByString:@","]];
    
    
    Mouse* mouseHelper = [[Mouse alloc]init];
    
    if(![mouseHelper addNewMouse:[self managedObjectContext] mouseName:mouseName gender:gender genotypes:genotypes dateOfBirth:dateOfBirth rackName:rackName cageRow:cageRow cageColoumn:cageColumn])
    {
        UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"Error!" message:@"There was a problem while saving the mouse details. Please try again" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }
    else
    {
        
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Success" message:@"Mouse details were saved successfully" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }
    
    
    
}




-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if([alertView.title isEqual:@"Success"])
    {
        if(buttonIndex==0 || buttonIndex
          ==1 ){
            
            [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
        }
    }
   }




-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.txtMouseName resignFirstResponder];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if(textField)
    {
        [textField resignFirstResponder];
    }
    return NO;
    
}


- (BOOL)disablesAutomaticKeyboardDismissal
{
    return NO;
}


-(BOOL)sanityCheck
{
    if(self.txtMouseName.text.length==0)
        return NO;
    if([self.btnChooseGenotype.currentTitle isEqual:@"Choose Genotype"])
        return NO;
    if(self.lblDate.text.length==0)
        return NO;
    if([self.btnSelectRack.currentTitle isEqual:@"Select Rack"])
        return NO;
    if([self.btnSelectCage.currentTitle isEqual:@"Select Cage"])
        return NO;
        
    return YES;
}

- (IBAction)selectRack:(id)sender {
    [rackPopoverController presentPopoverFromRect:[sender frame] inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    
    
}

- (IBAction)selectCage:(id)sender {
    
    [cagePopoverController presentPopoverFromRect:[sender frame] inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}


- (IBAction)cancelButtonClick:(id)sender {
    
    
    
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    
}


@end
