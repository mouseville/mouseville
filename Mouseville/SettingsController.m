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
    
    [self.labelView.layer setCornerRadius:30.0f];
    [self.labelView.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [self.labelView.layer setBorderWidth:1.5f];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)saveLabels:(id)sender {
    NSManagedObjectContext *context = [self managedObjectContext];
    Rack* rack = [[Rack alloc]init];
    
    Labels *labels1 = [[Labels alloc]init];
    
    [labels1 setLabel_id:[NSNumber numberWithInt:1]] ;
    [labels1 setLabel_name: self.label1.text];
    
    Labels *labels2 = [[Labels alloc]init];
    
    [labels2 setLabel_id:[NSNumber numberWithInt:2]] ;
    [labels2 setLabel_name: self.label2.text];
    
    Labels *labels3 = [[Labels alloc]init];
    
    [labels3 setLabel_id:[NSNumber numberWithInt:3]] ;
    [labels3 setLabel_name: self.label3.text];
    
    Labels *labels4 = [[Labels alloc]init];
    
    [labels4 setLabel_id:[NSNumber numberWithInt:4]] ;
    [labels4 setLabel_name: self.label4.text];
    
    Labels *labels5 = [[Labels alloc]init];
    
    [labels5 setLabel_id:[NSNumber numberWithInt:5]] ;
    [labels5 setLabel_name: self.label5.text];
    
    Labels *labels6 = [[Labels alloc]init];
    
    [labels6 setLabel_id:[NSNumber numberWithInt:6]] ;
    [labels6 setLabel_name: self.label6.text];
    
    
    NSArray *labelList = [[NSArray alloc] initWithObjects:labels1, labels2,labels3, labels4, labels5, labels6,nil];
    
    RackDetails *rackDetails = [[RackDetails alloc] init];
    [rackDetails setRack_name:self.rackName];
    
    if([rack setRackLabels:context rack:rackDetails labels: labelList])
    {
        UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"Success" message:@"Labels successfully updated" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    else{
        
        UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"ERROR!" message:@"Error updating labels!!" delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
        [alert show];
        
    }
}

- (IBAction)exportToCSV:(id)sender {
    
}
@end
