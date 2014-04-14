    //
//  EditMouseViewController.m
//  Mouseville
//
//  Created by Abhang Sonawane on 4/5/14.
//  Copyright (c) 2014 CapstoneProject. All rights reserved.
//

#import "EditMouseViewController.h"
#import "Mouse.h"
#import "Rack.h"
#import "Cage.h"
#import "GenotypeManager.h"
#import "GenotypeLabels.h"

@interface EditMouseViewController ()
{
    UIPopoverController* genotypePopoverController;
    PopOverViewController *genotypePopoverView;
    
    UIViewController* popoverContent ; //ViewController
    
    UIView *popoverDateView ;   //view
    
     UIPopoverController* popoverDateController;
    
    
}

@end

@implementation EditMouseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (IBAction)btnDateClick:(id)sender {
    
    popoverContent = [[UIViewController alloc] init]; //ViewController
    popoverDateView = [[UIView alloc] init];   //view
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


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    
    //getting a mouse from core data
    //replace the MouseDetails object here with whatever mouse you want to edit while loading this view.
    
    [self.editMouseView.layer setCornerRadius:30.0f];
    [self.editMouseView.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [self.editMouseView.layer setBorderWidth:1.5f];

    
    
    NSEntityDescription* mouseEntity = [NSEntityDescription entityForName:@"MouseDetails" inManagedObjectContext:[self managedObjectContext]];
    NSFetchRequest* fetchRequest = [[NSFetchRequest alloc]init];
    [fetchRequest setEntity:mouseEntity];
   
    /*
    NSError* errorRequest = Nil;
    
    NSArray* mice = [[self managedObjectContext]executeFetchRequest:fetchRequest error:&errorRequest];
     */
    
    
    self.genotypeMutableArray = [[NSMutableArray alloc]init];
    
    /*
    if([mice count]>0)
    {
        self.mouse = [mice objectAtIndex:0];
    }
    */
   [self performViewInitialization:self.mouse];
    
}

-(void)performViewInitialization:(MouseDetails*) mouse
{
 
    self.txtMouseName.text = mouse.mouse_name;
    
    if([mouse.gender isEqual:@"Male"])
    {
        [self.segMouseGender setSelectedSegmentIndex:0];
    }
    else
    {
        [self.segMouseGender setSelectedSegmentIndex:1];
    }
    
    GenotypeManager* genotypeManager = [[GenotypeManager alloc]init];
    
    genotypePopoverView = [[UIStoryboard storyboardWithName:@"Storyboard" bundle:nil]instantiateViewControllerWithIdentifier:@"dropdown"];
   
    [genotypePopoverView setIdentifier:@"genotypeDropDown"];
   
    genotypePopoverController = [[UIPopoverController alloc]initWithContentViewController:genotypePopoverView];
    
    genotypePopoverController.delegate = self;
    genotypePopoverView.delegate = self;
    
    genotypePopoverView.tableView.allowsMultipleSelection = YES;
    
    
    NSArray *allGenotypeLabels =[genotypeManager getAllgenotypes:[self managedObjectContext]];
    
    NSMutableArray* arr = [[NSMutableArray alloc]init];
    
    for(GenotypeLabels* individualGenotypeLable in allGenotypeLabels)
    {
        [arr addObject:individualGenotypeLable.genotypeLabel];
    }
    
    
    [genotypePopoverView setArrData:[NSArray arrayWithArray:arr]];
    
    
    NSArray* mouseGenotypes = [mouse.genotypes allObjects];
    
    NSMutableArray* mouseGenotypeStrings = [[NSMutableArray alloc]init];
    
    for(Genotype* individualGenotype in mouseGenotypes)
    {
        [mouseGenotypeStrings addObject:individualGenotype.genotype_name];
    }
    
    NSString* selectedGenotypes = [mouseGenotypeStrings componentsJoinedByString:@","];
    
    [self.btnChooseGenotype setTitle:selectedGenotypes forState:(UIControlStateNormal)];
    
    
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"MM/dd/yyyy"];
   
    self.lblDate.text = [dateFormatter stringFromDate:mouse.birth_date];
    
    [self.btnSelectRack setTitle:mouse.cageDetails.rackDetails.rack_name forState:(UIControlStateNormal)];
    
    NSMutableString* cageNameMutableString = [[NSMutableString alloc]init];
    
    [cageNameMutableString appendString:[self numberToAlphabet:mouse.cageDetails.row_id]];
    [cageNameMutableString appendString:[mouse.cageDetails.column_id stringValue ]];
    
    [self.btnSelectCage setTitle:[NSString stringWithString:cageNameMutableString] forState:UIControlStateNormal];
    
    if([mouse.is_deceased isEqual:@"Yes"])
    {
        [self.segMouseDeceased setSelectedSegmentIndex:1];
    }
    else
    {
        [self.segMouseDeceased setSelectedSegmentIndex:0];
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


- (IBAction)btnChooseGenotypeClick:(id)sender {
    
    [genotypePopoverController presentPopoverFromRect:[sender frame] inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];

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

-(void)didClickDropdown:(NSString *)string popoverIdentifier:(NSString *)popoverIdentifier
{
    if([popoverIdentifier isEqual:@"genotypeDropDown"])
    {
        if([self.genotypeMutableArray indexOfObject:string] == NSNotFound)
        {
            [self.genotypeMutableArray addObject:string];
        }
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


- (IBAction)cancelButtonClick:(id)sender {
    
    
    
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    
}



- (IBAction)btnSaveClick:(id)sender {
    
    if(![self sanityCheck])
    {
        UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Unablt to insert mouse details. Please ensure that all the values on this page are set" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
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
    
    //NSNumber* cageRow = [self alphabetToNumber:[tempMutableArray objectAtIndex:0 ]];
    //NSInteger cageColumnInteger = [[tempMutableArray objectAtIndex:1]intValue];
    //NSNumber* cageColumn = [NSNumber numberWithInteger:cageColumnInteger];
    
    //NSString* rackName = self.btnSelectRack.currentTitle;
    
    NSString* mouseName = self.txtMouseName.text;
    NSString* gender = [self.segMouseGender titleForSegmentAtIndex:self.segMouseGender.selectedSegmentIndex];
    NSString* deceased = [self.segMouseDeceased titleForSegmentAtIndex:self.segMouseDeceased.selectedSegmentIndex];
    
    NSDate* dateOfBirth = [dateFormatter dateFromString:self.lblDate.text];
    
    NSSet* genotypesLabel = [NSSet setWithArray:[self.btnChooseGenotype.currentTitle componentsSeparatedByString:@","]];
   
    for(NSString* individualLabel in genotypesLabel)
    {
        Genotype* genotypeEntity = [NSEntityDescription insertNewObjectForEntityForName:@"Genotype" inManagedObjectContext:[self managedObjectContext]];
        
        genotypeEntity.genotype_name = individualLabel;
        [self.mouse addGenotypesObject:genotypeEntity];
        
    }
    
    
    [self.mouse setMouse_name:mouseName];
    [self.mouse setGender:gender];
    [self.mouse setIs_deceased:deceased];
    [self.mouse setBirth_date:dateOfBirth];
    
    Mouse* mouseHelper = [[Mouse alloc]init];
    
    
    MouseDetails* tempMouse = [mouseHelper getMiceForRackCage:[self managedObjectContext] mouseName:mouseName gender:gender rack:self.mouse.cageDetails.rackDetails.rack_name cageRow:self.mouse.cageDetails.row_id cageColumn:self.mouse.cageDetails.column_id];
    
    if(tempMouse!=nil)
    {
        UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"Error!" message:@"Mouse with name already exists" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
        
    }
    
    
    else if([mouseHelper editMouseDetails:[self managedObjectContext] mouseDetails:self.mouse] == nil)
    {
     //   UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"Error!" message:@"There was a problem while saving the mouse details. Please try again" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
      //  [alert show];
        
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Success" message:@"Mouse details were saved successfully" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }
    
    else
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Success" message:@"Mouse details were saved successfully" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }
    
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



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
