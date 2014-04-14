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
    
    //self.label1.text = [Rack getLabelFromRack:<#(RackDetails *)#> withIndex:<#(int)#>]
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)saveLabels:(id)sender {
    NSManagedObjectContext *context = [self managedObjectContext];
    
    NSMutableArray* tempLabelsArray = [[NSMutableArray alloc]init];
    
    NSNumber *count = 0;
   
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

- (IBAction)exportToCSV:(id)sender {
  
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    spinner.center = CGPointMake(160, 240);
    spinner.hidesWhenStopped = YES;
    
    [self.view addSubview:spinner];
    [spinner startAnimating];
    
    NSString* csvPath = [self generateCSV];
    
    [spinner stopAnimating];
    
    [self  mail:csvPath];
    
}

-(void) mail:(NSString*) filePath
{
    if([MFMailComposeViewController canSendMail])
    {
        NSData* csvFile = [NSData dataWithContentsOfFile:filePath];
        
        MFMailComposeViewController* mailer = [[MFMailComposeViewController alloc]init];
        mailer.mailComposeDelegate = self;
        [mailer setSubject:@"Mouseville CSV File"];
        [mailer addAttachmentData:csvFile mimeType:@"text/csv" fileName:[filePath lastPathComponent]];
        
        //  [self presentViewController:mailer animated:YES completion:nil];
        
        [self presentViewController:mailer animated:YES completion:nil];
        
        
        
    }
    
    else{
        UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Device is not configured to send mail. Please check that you have set up your email and that netwoerk is available" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }
}



-(void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}



- (NSString*) generateCSV
{
    
    @try {
        NSArray* documentsPath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSSystemDomainMask, YES);
        NSString* documentDir = [documentsPath objectAtIndex:0];
        NSString* csvPath = [documentDir stringByAppendingPathComponent:@"export.csv"];
        
        Rack* rackObject = [[Rack alloc]init];
        
        NSArray* allRacks = [rackObject getAllRacks:[self managedObjectContext]];
        NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"MM/dd/yyyy"];
        
        
        
        CHCSVWriter* csvWriter = [[CHCSVWriter alloc]initForWritingToCSVFile:csvPath];
        
        
        
        NSMutableString* comment = [[NSMutableString alloc]init];
        
        [comment appendString:@"This file was generated on "];
        [comment appendString:[formatter stringFromDate:[NSDate date]]];
        
        [csvWriter writeComment:[NSString stringWithString:comment]];
        
        [csvWriter writeField:@"Rack Name"];
        [csvWriter writeField:@"Cage Name"];
        [csvWriter writeField:@"Mouse Name"];
        [csvWriter writeField:@"BirthDate"];
        [csvWriter writeField:@"Gender"];
        [csvWriter writeField:@"Genotype"];
        [csvWriter writeField:@"Family Details"];
        [csvWriter writeField:@"Is deceased"];
        [csvWriter finishLine];
        
        
        
        for(RackDetails* rack in allRacks)
        {
            for(CageDetails* cage in rack.cages)
            {
                if([cage.mouseDetails count]!=0)
                {
                    for(MouseDetails* mouse in cage.mouseDetails)
                    {
                        
                        
                        // sanition before writing
                        NSString* birthDate = [formatter stringFromDate:mouse.birth_date];
                        NSString* genoTypes = [[mouse.genotypes allObjects] componentsJoinedByString:@","];
                        NSString* familyDetails = [[mouse.miceFamilyDetails allObjects] componentsJoinedByString:@","];
                        NSMutableArray* tempArray = [[NSMutableArray alloc]init];
                        
                        [tempArray addObject:rack.rack_name];
                        [tempArray addObject:cage.cage_name];
                        [tempArray addObject:mouse.mouse_name];
                        [tempArray addObject:birthDate];
                        [tempArray addObject:mouse.gender];
                        [tempArray addObject:genoTypes];
                        [tempArray addObject:familyDetails];
                        [tempArray addObject:mouse.is_deceased];
                        
                        [csvWriter writeLineOfFields:tempArray];
                        
                        
                        
                    }
                }
            }
        }
        
        
        return csvPath;
        
    }
    @catch (NSException *exception) {
        NSLog(@"Exception %@     %@",exception, [exception reason]);
    }
    @finally {
        
    }
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.label1 resignFirstResponder];
    [self.label2 resignFirstResponder];
    [self.label3 resignFirstResponder];
    [self.label4 resignFirstResponder];
    [self.label5 resignFirstResponder];
    [self.label6 resignFirstResponder];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if(textField)
    {
        [textField resignFirstResponder];
    }
    return NO;
    
}
@end
