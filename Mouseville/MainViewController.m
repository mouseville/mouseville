//
//  ViewController.m
//  Mouseville
//
//  Created by Mouseville Team on 2/15/14.
//  Copyright (c) 2014 CapstoneProject. All rights reserved.
//

#import "MainViewController.h"
#import "Rack.h"
#import "Cage.h"
#import "RackController.h"

@interface MainViewController ()

@end

@implementation MainViewController
@synthesize rackView, miceView;



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
	// Do any additional setup after loading the view, typically from a nib.
    

    Rack* rack = [[Rack alloc]init];
    
    self.allRacks = [rack getAllRacks:[self managedObjectContext]];
    
    self.filteredRacks = [NSMutableArray arrayWithCapacity:[self.allRacks count]];
    
    [self.filteredRacks addObjectsFromArray:self.allRacks];
    
    [self.searchRacksText addTarget:self action:@selector(textDidChange:) forControlEvents:UIControlEventEditingChanged];
    
}



- (IBAction)mainViewChanged:(id)sender {
    
    
    
    
}




-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}


-(UICollectionViewCell*) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Rack" forIndexPath:indexPath];
    UILabel* label = (UILabel*) [cell viewWithTag:3];
    [label setText:[[self.filteredRacks objectAtIndex:indexPath.row]rack_name]];
    return cell;
    
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.filteredRacks count];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)createMice:(id)sender {
   
    
    //[self.rackView  addSubview:viewRacks.view];
}

- (IBAction)segmentedValueChanged:(UISegmentedControl *)sender {
    switch (sender.selectedSegmentIndex) {
        case 0:
            self.rackView.hidden=NO;
            self.miceView.hidden= YES;
            self.selectedIndexSegment = 0;
            break;
        case 1:
            self.rackView.hidden=YES;
            self.miceView.hidden= NO;
            self.selectedIndexSegment = 1;
            break;
            
        default:
            break;
    }
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"showRackDetails"]){
        NSManagedObjectContext *context = [self managedObjectContext];
        
        
        UICollectionViewCell *cel = (UICollectionViewCell *)[[sender superview] superview];
        
        UILabel *lab = (UILabel *)[cel.contentView viewWithTag:3];
        
        NSString* rackName = lab.text;
        
        
        Rack* rack = [[Rack alloc]init];
        Cage* cage = [[Cage alloc] init];
        
        RackDetails *rackDetailss = [rack getParticularRack:context rackName:rackName];
        NSArray *cageDetailss = [cage getAllCages:context rackId:rackDetailss.rack_id];
        
        ViewRacksController *viewRacksController = (ViewRacksController *)segue.destinationViewController;
        viewRacksController.viewRackDetails = rackDetailss;
        viewRacksController.rackLabel = rackName;
        viewRacksController.cageDetailsForRack = cageDetailss;
    }
}


-(void) textDidChange:(id)sender
{
    
    UITextField* searchField = (UITextField *) sender;
    
    if(searchField.text.length == 0)
    {
        self.isFiltered = FALSE;
        [self.filteredRacks removeAllObjects];
        [self.filteredRacks addObjectsFromArray:self.allRacks];
    }
    else
    {
        self.isFiltered = true;
        [self.filteredRacks removeAllObjects];
        self.filteredRacks = [[NSMutableArray alloc] init];
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.rack_name contains[c] %@",searchField.text];
        self.filteredRacks = [NSMutableArray arrayWithArray:[self.allRacks filteredArrayUsingPredicate:predicate]];
        
    }
    
    [self.rackCollection reloadData];
    
}


- (IBAction)segmentedAdd:(id)sender {
    NSLog(@"Selected index , %d",self.selectedIndexSegment);
    if (self.selectedIndexSegment == 0) {
        [self performSegueWithIdentifier:@"addRackSegue" sender:self];
    }else if (self.selectedIndexSegment == 1){
        [self performSegueWithIdentifier:@"addMouseSegue" sender:self];
    }
    
}
@end
