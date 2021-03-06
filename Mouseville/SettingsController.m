//
//  SettingsController.m
//  Mouseville
//
//  Created by nayan on 4/11/14.
//  Copyright (c) 2014 CapstoneProject. All rights reserved.
//

#import "SettingsController.h"
#import "Rack.h"
#import "RackDetails.h"
#import "Labels.h"

@interface SettingsController ()

@end

@implementation SettingsController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
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

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
   /** [self.image1.layer setCornerRadius:5.f];
    [self.image1.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [self.image1.layer setBorderWidth:1.0f];
    self.image1.autoresizingMask = (UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin| UIViewAutoresizingFlexibleTopMargin| UIViewAutoresizingFlexibleWidth);
    
    
    [self.image2.layer setCornerRadius:30.f];
    [self.image2.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [self.image2.layer setBorderWidth:1.5f];
    
    [self.image3.layer setCornerRadius:30.f];
    [self.image3.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [self.image3.layer setBorderWidth:1.5f];
    
    [self.image4.layer setCornerRadius:30.f];
    [self.image4.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [self.image4.layer setBorderWidth:1.5f];
    
    
    [self.image5.layer setCornerRadius:30.f];
    [self.image5.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [self.image5.layer setBorderWidth:1.5f];

    [self.image6.layer setCornerRadius:30.f];
    [self.image6.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [self.image6.layer setBorderWidth:1.5f];**/
    
    /*
    [self.labelView.layer setCornerRadius:30.0f];
    [self.labelView.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [self.labelView.layer setBorderWidth:1.5f];
    */
    
    
    self.label1.text = [[Rack getLabelFromRack:self.rackDetails withIndex:1] label_name];
    self.label2.text = [[Rack getLabelFromRack:self.rackDetails withIndex:2] label_name];
    self.label3.text = [[Rack getLabelFromRack:self.rackDetails withIndex:3] label_name];
    self.label4.text = [[Rack getLabelFromRack:self.rackDetails withIndex:4] label_name];
    self.label5.text = [[Rack getLabelFromRack:self.rackDetails withIndex:5] label_name];
    self.label6.text = [[Rack getLabelFromRack:self.rackDetails withIndex:6] label_name];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)saveLabels:(id)sender {
    NSManagedObjectContext *context = [self managedObjectContext];
    
    Labels *label;
    label = [Rack getLabelFromRack:self.rackDetails withIndex:1];
    label.label_name = self.label1.text;
    
    label = [Rack getLabelFromRack:self.rackDetails withIndex:2];
    label.label_name = self.label2.text;
    
    label = [Rack getLabelFromRack:self.rackDetails withIndex:3];
    label.label_name = self.label3.text;
    
    label = [Rack getLabelFromRack:self.rackDetails withIndex:4];
    label.label_name = self.label4.text;
    
    label = [Rack getLabelFromRack:self.rackDetails withIndex:5];
    label.label_name = self.label5.text;
    
    label = [Rack getLabelFromRack:self.rackDetails withIndex:6];
    label.label_name = self.label6.text;
    
    NSError *error = nil;
    
    if([context save:&error])
    {
        UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"Success" message:@"Labels successfully updated" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    else{
        
        UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"ERROR!" message:@"Error updating labels!!" delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
        [alert show];
        
    }
   
    ///example for first label.
    
    
    /*Labels *labels1 = [[Labels alloc]init];
    
    //[labels1 setLabel_id:[NSNumber numberWithInt:1]] ;
    [labels1 setLabel_name: self.label1.text];
    
    Labels *labels2 = [[Labels alloc]init];
    
    //[labels2 setLabel_id:[NSNumber numberWithInt:2]] ;
    [labels2 setLabel_name: self.label2.text];
    
    Labels *labels3 = [[Labels alloc]init];
    
    //[labels3 setLabel_id:[NSNumber numberWithInt:3]] ;
    [labels3 setLabel_name: self.label3.text];
    
    Labels *labels4 = [[Labels alloc]init];
    
    //[labels4 setLabel_id:[NSNumber numberWithInt:4]] ;
    [labels4 setLabel_name: self.label4.text];
    
    Labels *labels5 = [[Labels alloc]init];
    
    //[labels5 setLabel_id:[NSNumber numberWithInt:5]] ;
    [labels5 setLabel_name: self.label5.text];
    
    Labels *labels6 = [[Labels alloc]init];
    
    //[labels6 setLabel_id:[NSNumber numberWithInt:6]] ;
    [labels6 setLabel_name: self.label6.text];
    
    
    NSArray *labelList = [[NSArray alloc] initWithObjects:labels1, labels2,labels3, labels4, labels5, labels6,nil];
    
    RackDetails *rackDetails = self.rackDetails;
    
    if([rack setRackLabels:context rack:rackDetails labels: labelList])
    {
        UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"Success" message:@"Labels successfully updated" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    else{
        
        UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"ERROR!" message:@"Error updating labels!!" delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
        [alert show];
        
    }*/
}

@end
