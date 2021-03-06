//
//  CageViewController.m
//  Mouseville
//
//  Created by shnee on 3/29/14.
//  Copyright (c) 2014 CapstoneProject. All rights reserved.
//

#import "CageViewController.h"
#import "MouseDetails.h"
#import "CageDetails.h"
#import "MouseListViewController.h"
#import "Cage.h"

@interface CageViewController ()

@end

@implementation CageViewController

- (void)swapEditState {
    if (self.cageName.enabled == NO) {
        
        self.cageName.enabled = YES;
        self.cageName.borderStyle = UITextBorderStyleRoundedRect;
        self.CageNotes.editable = YES;
        [self.CageNotes.layer setCornerRadius:8.0f];
        [self.CageNotes.layer setBorderColor:[UIColor lightGrayColor].CGColor];
        [self.CageNotes.layer setBorderWidth:1.5f];
        
    } else {
        // save fields to cage
        self.cage.cage_name = self.cageName.text;
        self.cage.notes = self.CageNotes.text;
        
        NSManagedObjectContext *context = [self managedObjectContext];
        
        Cage *tmp = [[Cage alloc]init];
        
        [tmp editParticularCage:context rack:self.cage.rackDetails row:self.cage.row_id column:self.cage.column_id cageObject:self.cage];
        
        self.cageName.enabled = NO;
        self.cageName.borderStyle = UITextBorderStyleNone;
        self.CageNotes.editable = NO;
        [self.CageNotes.layer setBorderWidth:0.0f];
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    [self swapEditState];
    return YES;
}

- (IBAction)editButtonClicked:(id)sender {
    [self swapEditState];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    MouseListViewController *transferVC = segue.destinationViewController;
    transferVC.currentCage = self.cage;
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

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}

- (IBAction)labelChecked:(id)sender {
    UISwitch *switched = (UISwitch *)sender;
    int labelChecked = [sender tag] - 60;
    
    //NSMutableSet *cageLabels = [NSMutableSet setWithSet:self.cage.labels];
    
    NSManagedObjectContext *context = [self managedObjectContext];
    
    switch (labelChecked) {
        case 1:
            self.cage.label1 = switched.on;
            break;
        case 2:
            self.cage.label2 = switched.on;
            break;
        case 3:
            self.cage.label3 = switched.on;
            break;
        case 4:
            self.cage.label4 = switched.on;
            break;
        case 5:
            self.cage.label5 = switched.on;
            break;
        case 6:
            self.cage.label6 = switched.on;
            
        default:
            break;
    }
    
    //[[[Cage alloc] init] setLabelsForCage:context cage:self.cage labels:[self.cage.labels allObjects]];
    NSError *error = nil;
    if(![context save:&error])
    {
        NSLog(@"Unable to save label information %@ %@",error, [error localizedDescription]);
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    // take care of CageEdit View
    [self.CageInfo.layer setCornerRadius:30.0f];
    [self.CageInfo.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [self.CageInfo.layer setBorderWidth:1.5f];
    
    // mouse list container
    [self.mouseListContainter.layer setCornerRadius:30.0f];
    [self.mouseListContainter.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [self.mouseListContainter.layer setBorderWidth:1.5f];
    
    // check if cage name is empty
    if (self.cage.cage_name == nil) {
        self.cageName.text = [NSString stringWithFormat:@"Cage %@%@", [Cage numberToAlphabet:self.cage.column_id], self.cage.row_id];
    } else {
        self.cageName.text = self.cage.cage_name;
    }
    
    // check if cage notes is empty
    if (self.cage.notes == nil) {
        self.CageNotes.text = @"Enter noters here.";
    } else {
        self.CageNotes.text = self.cage.notes;
    }
    
    // Labels
    [self.Label1View.layer setCornerRadius:30.f];
    [self.Label1View.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [self.Label1View.layer setBorderWidth:1.5f];
    self.Label1.text = [[Rack getLabelFromRack:self.cage.rackDetails withIndex:1] label_name];
    self.Label1Switch.on = self.cage.label1;
    
    [self.Label2View.layer setCornerRadius:30.f];
    [self.Label2View.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [self.Label2View.layer setBorderWidth:1.5f];
    self.Label2.text = [[Rack getLabelFromRack:self.cage.rackDetails withIndex:2] label_name];
    self.Label2Switch.on = self.cage.label2;
    
    [self.Label3View.layer setCornerRadius:30.f];
    [self.Label3View.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [self.Label3View.layer setBorderWidth:1.5f];
    self.Label3.text = [[Rack getLabelFromRack:self.cage.rackDetails withIndex:3] label_name];
    self.Label3Switch.on = self.cage.label3;
    
    [self.Label4View.layer setCornerRadius:30.f];
    [self.Label4View.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [self.Label4View.layer setBorderWidth:1.5f];
    self.Label4.text = [[Rack getLabelFromRack:self.cage.rackDetails withIndex:4] label_name];
    self.Label4Switch.on = self.cage.label4;
    
    [self.Label5View.layer setCornerRadius:30.f];
    [self.Label5View.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [self.Label5View.layer setBorderWidth:1.5f];
    self.Label5.text = [[Rack getLabelFromRack:self.cage.rackDetails withIndex:5] label_name];
    self.Label5Switch.on = self.cage.label5;
    
    [self.Label6View.layer setCornerRadius:30.f];
    [self.Label6View.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [self.Label6View.layer setBorderWidth:1.5f];
    self.Label6.text = [[Rack getLabelFromRack:self.cage.rackDetails withIndex:6] label_name];
    self.Label6Switch.on = self.cage.label6;}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
