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
    
    UILongPressGestureRecognizer *lpr = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(didLongPressCellToDelete:)];
    
    lpr.minimumPressDuration = .5;
    lpr.delegate = self;
    
    [self.rackCollection addGestureRecognizer:lpr];
    
    [self.rackCollection reloadData];
    
    UIMenuItem *renameItem = [[UIMenuItem alloc] initWithTitle:@"Edit" action:@selector(rename:)];
    UIMenuItem *deleteItem = [[UIMenuItem alloc] initWithTitle:@"Delete" action:@selector(delete:)];
    
    [[UIMenuController sharedMenuController] setMenuItems:[NSArray arrayWithObjects:renameItem, deleteItem, nil]];
    
}

-(void) viewDidAppear:(BOOL)animated{
    [self viewDidLoad];

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

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}


-(BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender{
    if ((action == @selector(delete:)) || (action == @selector(rename:))){
        return YES;
    }
    return NO;
}

-(BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

-(void)rename:(UIMenuController *)menuController{
    
}

-(void) delete:(id)sender{
    UICollectionView *collection = (UICollectionView*)[self.rackCollection superview];
    if ([collection isKindOfClass:[UICollectionView class]]) {
        id <UICollectionViewDelegate> d = collection.delegate;
        if ([d respondsToSelector:@selector(collectionView:performAction:forItemAtIndexPath:withSender:)]) {
            [d collectionView:collection performAction:@selector(delete:) forItemAtIndexPath:[collection indexPathForCell:collection] withSender:sender];
        }
    }
}

- (IBAction)didLongPressCellToDelete:(UILongPressGestureRecognizer*)gesture {
    CGPoint tapLocation = [gesture locationInView:self.rackCollection];
    NSIndexPath *indexPath = [self.rackCollection indexPathForItemAtPoint:tapLocation];
    if (indexPath && gesture.state == UIGestureRecognizerStateBegan) {
        NSLog(@"image with index %d to be deleted", indexPath.item);
        
        UICollectionViewCell *cell = [self.rackCollection cellForItemAtIndexPath:indexPath];
        
        self.deleteRackName = ((UILabel *)[cell.contentView viewWithTag:3]).text;
        UIAlertView *deleteAlert = [[UIAlertView alloc]
                                    initWithTitle:@"Delete?"
                                    message:@"Are you sure you want to delete this rack?"
                                    delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Yes", nil];
        [deleteAlert show];
        
    }
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSLog(@"selected button index = %d", buttonIndex);
    if (buttonIndex == 1) {
        // Do what you need to do to delete the cell
        Rack *rack = [[Rack alloc] init];
        NSManagedObjectContext *context = [self managedObjectContext];
        
        
        if ([rack deleteRack:context rackName:self.deleteRackName]) {
            UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"Success" message:@"Rack has been deleted" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
        else{
            
            UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"ERROR!" message:@"Error deleting rack!!!" delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
            [alert show];
            
        }

        [self.rackCollection reloadData];
        [self viewDidLoad];
    }
}
@end
