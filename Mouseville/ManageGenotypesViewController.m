    //
//  ManageGenotypesViewController.m
//  Mouseville
//
//  Created by Abhang Sonawane on 4/4/14.
//  Copyright (c) 2014 CapstoneProject. All rights reserved.
//

#import "ManageGenotypesViewController.h"
#import "Rack.h"
#import "RackDetails.h"
#import "Labels.h"

@interface ManageGenotypesViewController ()

@end


@implementation ManageGenotypesViewController

@synthesize genotypes, genotypeTableView;


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
   
   // genotypes= [[NSMutableArray alloc] init:@"gene1", @"gene2", @"gene3", nil];
   
    GenotypeManager* genotypeManager = [[GenotypeManager alloc]init];
    NSArray* allGenotypeLabels = [genotypeManager getAllgenotypes:[self managedObjectContext]];
    genotypes = [[NSMutableArray alloc]init];
    
    for(GenotypeLabels* individualGenotypeLable in allGenotypeLabels)
    {
        [genotypes addObject:individualGenotypeLable.genotypeLabel];
    }
    
   self.navigationItem.rightBarButtonItem=self.editButtonItem;
    
    
    [self.genesView.layer setCornerRadius:10.0f];
    [self.genesView.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [self.genesView.layer setBorderWidth:1.5f];
    

    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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


-(void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];
    [genotypeTableView setEditing:editing animated:animated];
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return genotypes.count;
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellName= @"geneCell";
    UITableViewCell *cell= [tableView dequeueReusableCellWithIdentifier:cellName];
    
    if(cell==nil)
    {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        
    }
    
    cell.textLabel.text=[genotypes objectAtIndex:indexPath.row];
    return cell;
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(editingStyle==UITableViewCellEditingStyleDelete)
    {
        [genotypes removeObjectAtIndex:indexPath.row];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    
}

-(void)tableView:(UITableView *)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
//    GenotypeManager* genotypeManager = [[GenotypeManager alloc]init];
//    
//    if(![genotypeManager updateAllGenotypes:[self managedObjectContext] genotypeLabelsArray:[NSArray arrayWithArray:genotypes]])
//    {
//        UIAlertView* alertView =[[UIAlertView alloc]initWithTitle:@"Error!" message:@"There was error in saving genotype to the database. Please try again" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
//        [alertView show];
//    }
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    GenotypeManager* genotypeManager = [[GenotypeManager alloc]init];
    
    if(![genotypeManager updateAllGenotypes:[self managedObjectContext] genotypeLabelsArray:[NSArray arrayWithArray:genotypes]])
    {
        UIAlertView* alertView =[[UIAlertView alloc]initWithTitle:@"Error!" message:@"There was error in saving genotype to the database. Please try again" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alertView show];
    }

}

- (IBAction)insertNewGenotype:(id)sender {
    
    UIAlertView * alert= [[UIAlertView alloc] initWithTitle:@"Enter New Genotype" message:@"" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    alert.alertViewStyle=UIAlertViewStylePlainTextInput;
    [alert show];
}

-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==1)
    {
        NSString *tempGene = [alertView textFieldAtIndex:0].text;
        
        if(!genotypes)
        {
            genotypes= [[NSMutableArray alloc] init];
        }
        
        [genotypes insertObject:tempGene atIndex:0] ;
        NSIndexPath *indexPath= [NSIndexPath indexPathForRow:0 inSection:0];
        
        [self.genotypeTableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
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








