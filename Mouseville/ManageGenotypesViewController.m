//
//  ManageGenotypesViewController.m
//  Mouseville
//
//  Created by Abhang Sonawane on 4/4/14.
//  Copyright (c) 2014 CapstoneProject. All rights reserved.
//

#import "ManageGenotypesViewController.h"

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
   
    genotypes= [[NSMutableArray alloc] initWithObjects:@"gene1", @"gene2", @"gene3", nil];
    
    self.navigationItem.rightBarButtonItem=self.editButtonItem;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
@end








