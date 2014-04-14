//
//  RackController.m
//  Mouseville
//
//  Created by nayan on 3/29/14.
//  Copyright (c) 2014 CapstoneProject. All rights reserved.
//

#import "RackController.h"
#import "RackDetails.h"
#import "Rack.h"

@implementation RackController



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
    

    
    self.rowStepper.minimumValue = 1;
    self.rowStepper.maximumValue = 10;
 
    
    
    
    NSUInteger numberOfRows = self.rowStepper.value;
    self.rowLabel.text = [NSString stringWithFormat:@"%2lu", (unsigned long)numberOfRows];
    
    
    self.columnStepper.minimumValue = 1;
    self.columnStepper.maximumValue = 7;
    NSUInteger numberOfColumns = self.columnStepper.value;
    self.columnLabel.text = [NSString stringWithFormat:@"%2lu", (unsigned long)numberOfColumns];
  

}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onRowChange:(UIStepper *)sender {
    NSUInteger numberOfRow  = sender.value;
    self.rowLabel.text = [NSString stringWithFormat:@"%2lu", (unsigned long)numberOfRow];
    
    [self.tableCollection reloadData];
}

- (IBAction)onColumnAction:(UIStepper *)sender {
    
    NSUInteger numberOfColumns = self.columnStepper.value;
    self.columnLabel.text = [NSString stringWithFormat:@"%2lu", (unsigned long)numberOfColumns];
    [self.tableCollection reloadData];
}

- (IBAction)cancelButtonClick:(id)sender {
    
    [self.presentingViewController dismissViewControllerAnimated:YES completion:^{
        [self
         viewDidLoad];}];
}

-(NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    NSInteger counter = self.rowStepper.value ;
    return counter;
}


-(NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    NSInteger counter = self.columnStepper.value;
    
    return counter;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
   
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
   
    UILabel *label = (UILabel *) [cell viewWithTag:2];
    label.text = @"";
    
    [cell.layer setCornerRadius:5.f
     ];
   [cell.layer setBorderWidth:1.0f];
  [cell.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    
    
    return cell;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.rackNameText resignFirstResponder];
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



-(NSManagedObjectContext*) managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication]delegate];
    if([delegate performSelector:@selector(managedObjectContext)])
    {
        context = [delegate managedObjectContext];
    }
    
    return context;
}

- (IBAction)insertNewRack:(id)sender {

    if(![self sanityCheck])
    {
        UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Unable to create rack. Please ensure that all the values on this page are set" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
        return;
    }
    
    NSManagedObjectContext *context = [self managedObjectContext];
    
    NSString* rackName = self.rackNameText.text;
    NSNumber* number_rows = [[NSNumber alloc]initWithDouble:self.rowStepper.value];
    NSNumber* number_columns = [[NSNumber alloc]initWithDouble:self.columnStepper.value];
    // create 6 empty labels
    NSMutableSet *rack_labels = [[NSMutableSet alloc]  init];
    for (int i = 0; i < 6; i++) {
        Labels *label = [NSEntityDescription insertNewObjectForEntityForName:@"Labels" inManagedObjectContext:context];
        label.label_name = @"";
        label.label_order = [NSNumber numberWithInt:i+1];
        [rack_labels addObject:label];
    }
    
    Rack* rack = [[Rack alloc]init];
    
    RackDetails* tempRack = [rack getParticularRack:context rackName:rackName];
    
    if(tempRack!=nil)
    {
        UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Rack with same name already exists" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    
   else if([rack addNewRack:context name:rackName rows:number_rows columns:number_columns withLabels:rack_labels])
   {
       UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"Success" message:@"New Rack has been created" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
       [alert show];
   }
   else{
       
       UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"ERROR!" message:@"Error creating new rack!!!" delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
       [alert show];
       
   }
    
    
}

-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if([alertView.title isEqual:@"Success"])
    {
        if(buttonIndex==0 || buttonIndex
           ==1 ){
            
          //  [[NSNotificationCenter defaultCenter] postNotificationName:@"updateParent" object:nil];
            
            [self.presentingViewController dismissViewControllerAnimated:YES completion:^{
                [self viewDidLoad];}];        }
    }
}



-(BOOL)sanityCheck
{
    if(self.rackNameText.text.length==0)
        return NO;
    
    return YES;
}
@end
