//
//  ViewController.m
//  Mouseville
//
//  Created by abhang on 3/25/14.
//  Copyright (c) 2014 CapstoneProject. All rights reserved.
//

#import "ViewController.h"
#import "CageViewController.h"
#import "AppDelegate.h"
#import "UserDetails.h"
//#import "TestViewController.h"


@interface ViewController ()

@end

@implementation ViewController


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

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    NSManagedObjectContext *context = [self managedObjectContext];
    NSEntityDescription* userDetailsEntity = [NSEntityDescription entityForName:@"UserDetails" inManagedObjectContext:context];
    NSFetchRequest* fetchRequest = [[NSFetchRequest alloc]init];
    [fetchRequest setEntity:userDetailsEntity];
    
    NSError *error = nil;
    
    NSArray* user = [context executeFetchRequest:fetchRequest error:&error];
    
    if(error)
    {
        NSLog(@"Error fetching user details: %@ %@",error,[error localizedDescription]);
        return;
    }
    
    
    if([user count] == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Hello" message:@"Please let us know your name" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        alert.alertViewStyle = UIAlertViewStylePlainTextInput;
        [alert show];
        
    }

    //[self createTestRack];
}

-(void)alertView:(UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSManagedObjectContext *context = [self managedObjectContext];
    UserDetails *userDetails = [NSEntityDescription insertNewObjectForEntityForName:@"UserDetails" inManagedObjectContext:context];
    
    userDetails.user_name = [[alertView textFieldAtIndex:0]text];

    
    NSError* error = nil;
    
    if(![context save:&error])
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error" message:[error localizedDescription] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    
    [[self Label]setText:userDetails.user_name];
        
    
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    CageViewController *transferVC = segue.destinationViewController;
    
    if ([segue.identifier isEqualToString:@"cageViewSegue"]) {
        transferVC.cage = [self.testRack.cages anyObject];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)PushCageButton:(id)sender {
}

- (void)createTestRack {
    NSManagedObjectContext *context = [self managedObjectContext];
    self.testRack = [NSEntityDescription insertNewObjectForEntityForName:@"RackDetails" inManagedObjectContext:context];
    
    self.testRack.created_date = [NSDate date];
    self.testRack.notes = @"This is a test rack";
    self.testRack.number_columns = [NSNumber numberWithInt:3];
    self.testRack.number_rows = [NSNumber numberWithInt:2];
    self.testRack.rack_name = @"Test Rack";
    
    for (int x = 0; x < 3; x++) {
        for (int y = 0; y < 2; y++) {
            //create a dummy cage with mice
            CageDetails *cage = [NSEntityDescription insertNewObjectForEntityForName:@"CageDetails" inManagedObjectContext:context];
            cage.cage_name = [NSString stringWithFormat:@"Test Cage %d.%d", y + 1, x + 1];
            cage.notes = @"This is a test cage";
            for(int i = 0; i < 5; i++) {
                MouseDetails *mouse = [NSEntityDescription insertNewObjectForEntityForName:@"MouseDetails" inManagedObjectContext:context];
                mouse.mouse_name = [NSString stringWithFormat:@"Mouse %d.%d.%d", y + 1, x + 1, i + 1];
                [cage addMouseDetailsObject:mouse];
            }
            cage.row_id = [NSNumber numberWithInt:y + 1];
            cage.column_id = [NSNumber numberWithInt:x + 1];
            [self.testRack addCagesObject:cage];
        }
    }
    
}
- (IBAction)btnExport:(id)sender {
    
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
                        [tempArray addObject:cage.cage_name == nil?@"No Name":cage.cage_name];
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



@end
