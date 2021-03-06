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
#import "PopOverViewController.h"
#import "GenotypeManager.h"
#import "MouseViewController.h"
#import "Mouse.h"
#import "UserDetails.h"
#import "SearchMouseSectionsController.h"


@interface MainViewController ()
{
    
    UIPopoverController *popoverController;
    PopOverViewController *popoverView;
    BOOL isViewExpanded;
}

@end

@implementation MainViewController
{
    NSDictionary *racklist;
    NSArray *rackSectionTitles;
}
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

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
//    [self.searchRacksText resignFirstResponder];
//     [self.txtSearch resignFirstResponder];
}

//-(BOOL)textFieldShouldReturn:(UITextField *)textField
//{
//    if(textField)
//    {
//        [textField resignFirstResponder];
//    }
//    return NO;
//    
//}





- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    isViewExpanded = NO;

    Rack* rack = [[Rack alloc]init];
    
    self.allRacks = [rack getAllRacks:[self managedObjectContext]];
    
    
    self.allMouseDetails = [[NSMutableArray alloc]init];
  
    self.allDeceasedMouseDetails = [[NSMutableArray alloc]init];
    
    Mouse* tempMouse = [[Mouse alloc]init];
    NSArray* allAliveMice = [tempMouse miceResult:[self managedObjectContext] mouseName:@"" gender:@"" genotype:@"" weekRange:nil];
    
    NSArray* allDeceasedMice = [tempMouse getAllDeceasedMice:[self managedObjectContext]];
    
    [self.allMouseDetails addObjectsFromArray:allAliveMice];
    [self.allMouseDetails addObjectsFromArray:allDeceasedMice];
    
    /*
    if([self.allRacks count]==0){
    UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"Welcome" message:@"Please create a rack to get started!" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        
        
    [alert show];
    }
     
     */
    
    self.filteredRacks = [NSMutableArray arrayWithCapacity:[self.allRacks count]];
    
    [self.filteredRacks addObjectsFromArray:self.allRacks];
    
    //[self.searchRacksText addTarget:self action:@selector(textDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    UILongPressGestureRecognizer *lpr = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(didLongPressCellToDelete:)];
    
    lpr.minimumPressDuration = .5;
    lpr.delegate = self;
    
    [self.rackCollection addGestureRecognizer:lpr];
    
    [self.rackCollection reloadData];
    
    UIMenuItem *renameItem = [[UIMenuItem alloc] initWithTitle:@"Edit" action:@selector(rename:)];
    UIMenuItem *deleteItem = [[UIMenuItem alloc] initWithTitle:@"Delete" action:@selector(delete:)];
    
    [[UIMenuController sharedMenuController] setMenuItems:[NSArray arrayWithObjects:renameItem, deleteItem, nil]];
    
    
    
    
    //code for search mouse
    

    self.slider.maximumValue= 100;
    self.slider.minimumValue=0;
    self.slider.value=0;
    
    self.slider2.maximumValue=100;
    self.slider2.minimumValue=0;
    self.slider2.value=100;
 
    
    self.label1.text =[NSString stringWithFormat:@"%.0f to %.0f weeks", self.slider.value, self.slider2.value];
    
    racklist = @{@"Rack 1" : @[@"Mouse 1A", @"Mouse 2A", @"Mouse 3A", @"Mouse 4A"],
                 @"Rack 2" : @[@"Mouse 1B", @"Mouse 2B", @"Mouse 3B", @"Mouse 4B"],
                 @"Rack 3" : @[@"Mouse 1C", @"Mouse 2C", @"Mouse 3C", @"Mouse 4C"],
                 @"Rack 4" : @[@"Mouse 1D", @"Mouse 2D", @"Mouse 3D", @"Mouse 4D"]};
    
    rackSectionTitles = [[racklist allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];

    
    
    
    GenotypeManager* genotypeManager = [[GenotypeManager alloc]init];
    
    
    
    NSArray *allGenotypeLabels =[genotypeManager getAllgenotypes:[self managedObjectContext]];
    
    
    NSMutableArray* arr = [[NSMutableArray alloc]init];
    
    for(GenotypeLabels* individualGenotypeLable in allGenotypeLabels)
    {
        [arr addObject:individualGenotypeLable.genotypeLabel];
    }
    
    self.genotypeMutableArray = [[NSMutableArray alloc]init];
    
    
    popoverView = [[UIStoryboard storyboardWithName:@"Storyboard" bundle:nil]instantiateViewControllerWithIdentifier:@"dropdown"];
    [popoverView setArrData:arr];
    popoverController = [[UIPopoverController alloc]initWithContentViewController:popoverView];
    popoverView.delegate = self;
    [popoverView setIdentifier:@"genotypeDropDown"];
    popoverView.tableView.allowsMultipleSelection = YES;
   
    
    
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
        [alert setTag:1];
        [alert show];
        
    }
    
    //[self createTestRack];
}


    


-(void) viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    
   //     [self.txtSearch resignFirstResponder];
  // [self viewDidLoad];

    
    //[self.txtSearch becomeFirstResponder];
    

}


-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
   // [self viewDidLoad];
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

-(void) reloadMouseArrayDetails
{
    Mouse* tempMouse = [[Mouse alloc]init];
    
    [self.allMouseDetails removeAllObjects];
    [self.allDeceasedMouseDetails removeAllObjects];
    
    self.allMouseDetails = [NSMutableArray arrayWithArray:[tempMouse miceResult:[self managedObjectContext] mouseName:@"" gender:@"" genotype:@"" weekRange:nil]];
    self.allDeceasedMouseDetails = [NSMutableArray arrayWithArray:[tempMouse miceResultDeceased:[self managedObjectContext] mouseName:@"" gender:@"" genotype:@"" weekRange:nil]];
    
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
            [self reloadMouseArrayDetails];
            [self.delegate reloadDetails:self.allMouseDetails allDeceasedMouseDetails:self.allDeceasedMouseDetails];
            
            
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
    
    else if([segue.identifier isEqualToString:@"mouseCollectionSegue"])
    {
        SearchMouseSectionsController *searchMouse = (SearchMouseSectionsController *)segue.destinationViewController;
        
        
        //if (!self.isViewLoaded) {
           // [self viewDidLoad];
        //}
        
        
        Mouse* tempMouse = [[Mouse alloc]init];
        
        searchMouse.allMouseDetails = [NSMutableArray arrayWithArray:[tempMouse miceResult:[self managedObjectContext] mouseName:@"" gender:@"" genotype:@"" weekRange:nil]];
        
        searchMouse.allDeceasedMouseDetails = [NSMutableArray arrayWithArray:[tempMouse getAllDeceasedMice:[self managedObjectContext]]];
        
        self.delegate = searchMouse;
    }
}



//-(void) textDidChange:(id)sender
//{
//    
//    
//    UITextField* searchField = (UITextField *) sender;
//    if (searchField.text == self.searchRacksText.text) {
//        NSLog(@"SEarch %@",self.searchRacksText.text);
//    if(searchField.text.length == 0)
//    {
//        self.isFiltered = FALSE;
//        [self.filteredRacks removeAllObjects];
//        [self.filteredRacks addObjectsFromArray:self.allRacks];
//    }
//    else
//    {
//        
//        
//    }
//    
//    [self.rackCollection reloadData];
//    }
//    
//}

- (IBAction)segmentedAdd:(id)sender {
  
    /*
    NSLog(@"Selected index , %d",self.selectedIndexSegment);
    if (self.selectedIndexSegment == 0) {
        [self performSegueWithIdentifier:@"addRackSegue" sender:self];
    }else if (self.selectedIndexSegment == 1){
        [self performSegueWithIdentifier:@"addMouseSegue" sender:self];
    }
     
     */
    
    
     if (self.selectedIndexSegment == 0) {
        // [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(viewDidLoad) name:@"updateParent" object:nil];
         

         
         RackController *viewController= [[UIStoryboard storyboardWithName:@"Storyboard" bundle:nil]instantiateViewControllerWithIdentifier:@"rackController"];
  
         viewController.delegate = self;
    //     RackController *viewController= [[RackController alloc] init];
         viewController.modalPresentationStyle=UIModalPresentationFormSheet;
         viewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
         
         [self presentViewController:viewController animated:YES completion:^{
             viewController.view.superview.frame = CGRectMake(0, 0, 700, 933);
             viewController.view.superview.center = self.view.center;
             [self.view setNeedsDisplay];

         }];
         
         
         
        }
     else if (self.selectedIndexSegment == 1)
        {
          //  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(viewDidLoad) name:@"updateParent" object:nil];
            
            MouseViewController *viewController= [[UIStoryboard storyboardWithName:@"Storyboard" bundle:nil]instantiateViewControllerWithIdentifier:@"mouseController"];
            viewController.delegate = self;
            viewController.modalPresentationStyle=UIModalPresentationFormSheet;
            viewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
            
            [self presentViewController:viewController animated:YES completion:^{
                viewController.view.superview.frame = CGRectMake(0, 0, 700, 933);
                viewController.view.superview.center = self.view.center;
            [self.view setNeedsDisplay];
            }];
            

        }
}

-(void)reloadDetails{
    
    Rack* rack = [[Rack alloc]init];
    
    self.allRacks = [rack getAllRacks:[self managedObjectContext]];
    [self.filteredRacks removeAllObjects];
    [self.filteredRacks addObjectsFromArray:self.allRacks];
    [self.rackCollection reloadData];
    
    [self reloadMouseArrayDetails];
    
    
    if([self.delegate respondsToSelector:@selector(reloadDetails:allDeceasedMouseDetails:)])
    {
        [self.delegate reloadDetails:self.allMouseDetails allDeceasedMouseDetails:self.allDeceasedMouseDetails];
    }

    
    
}

//Code for search mouse view







- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSString *sectionTitle = [rackSectionTitles objectAtIndex:section];
    NSArray *sectionRacks = [racklist objectForKey:sectionTitle];
    return [sectionRacks count];
}

- (NSInteger)numberofSectionsInTableView:(UITableView *)tableView {
    return [rackSectionTitles count];
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
        [deleteAlert setTag:2];
        [deleteAlert show];
        
        
    }
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSLog(@"selected button index = %d", buttonIndex);
    
    
    

    
    
    if(alertView.tag ==1)
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
        
     //   [[self Label]setText:userDetails.user_name];
        
        
    }
    
    
    
    
    else if (buttonIndex == 1 && alertView.tag ==2)
    {
        
        
        
        
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
- (NSArray *)sectionIndexTilesForTableView:(UITableView *)tableView {
    return rackSectionTitles;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    NSString *sectionTitle = [rackSectionTitles objectAtIndex:indexPath.section];
    NSArray *sectionRacks = [racklist objectForKey:sectionTitle];
    NSString *rack = [sectionRacks objectAtIndex:indexPath.row];
    cell.textLabel.text = rack;
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [rackSectionTitles objectAtIndex:section];
}



-(void) didClickDropdown:(NSString *)string popoverIdentifier:(NSString *)popoverIdentifier
{
    
    if([popoverIdentifier isEqual:@"genotypeDropDown"])
    {
        [self.genotypeMutableArray addObject:string];
    }
}


-(void)didDeSelectClickDropdown:(NSString *)string popoverIdentifier:(NSString *)popoverIdentifier
{
    
    if([popoverIdentifier isEqual:@"genotypeDropDown"])
    {
        [self.genotypeMutableArray removeObject:string];
    }
}

-(void)dropDownWillDisappear:(NSString *)popoverIdentifier
{
    if([popoverIdentifier isEqual:@"genotypeDropDown"])
    {
        if([self.genotypeMutableArray count]!=0)
            [[self btnChooseGenotype]setTitle:[[self.genotypeMutableArray sortedArrayUsingSelector:@selector(localizedStandardCompare:)]componentsJoinedByString:@","] forState:UIControlStateNormal];
        else
            [[self btnChooseGenotype]setTitle:@"Select" forState:UIControlStateNormal];
    }
}



- (IBAction)sliderValueChanged:(id)sender {
    
    if(self.slider.value>self.slider2.value)
    {
        self.slider2.value=self.slider.value;
    }
    
    self.label1.text =[NSString stringWithFormat:@"%.0f to %.0f weeks", self.slider.value, self.slider2.value];
    
    
}



- (IBAction)chooseGenotype:(id)sender {
    [popoverController presentPopoverFromRect:[sender frame] inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

- (IBAction)expandClicked:(id)sender {
    
    if(!isViewExpanded){
        [UIView animateWithDuration:0.4f animations:^{
           /*            CGRect bounds = [self.containerView bounds];
            [self.containerView setBounds:CGRectMake(bounds.origin.x,
                                            bounds.origin.y,
                                            bounds.size.width,
                                            550)];
            
            
            */
            
            [[self btnChooseGenotype]setTitle:@"Select" forState:UIControlStateNormal];
            
            self.slider.value=0;
            self.slider2.value=100;
            self.genderSegment.selectedSegmentIndex=0;
            
            self.label1.text =[NSString stringWithFormat:@"%.0f to %.0f weeks", self.slider.value, self.slider2.value];

            self.slideThisView.transform = CGAffineTransformMakeTranslation(0, 252);
            
        } completion:^(BOOL finished) {
            
        }];
        
        [self.expandButton setTitle:@"Less" forState:UIControlStateNormal];
    }
    else{
        
        /*
        CGRect bounds = [self.containerView bounds];
        [self.containerView setBounds:CGRectMake(bounds.origin.x,
                                                 bounds.origin.y,
                                                 bounds.size.width,
                                                 700)];
        
         
         */
        
        [UIView animateWithDuration:0.4f animations:^{
            
            
            
            self.slideThisView.transform = CGAffineTransformIdentity;
            
        } completion:^(BOOL finished) {
            
        }];
       [self.expandButton setTitle:@"More Search Options" forState:UIControlStateNormal];
    }
    isViewExpanded = !isViewExpanded;
    
    
}
- (IBAction)slider2ValueChanged:(id)sender {
    
    
    if(self.slider.value>self.slider2.value)
    {
        self.slider.value=self.slider2.value;
    }
    
    self.label1.text =[NSString stringWithFormat:@"%.0f to %.0f weeks", self.slider.value, self.slider2.value];
    
    
}

/*

-(int) getWeeksFromDate: (NSDate*) date
{
    //NSDateFormatter if format error
    
    NSDate* currentDate = [[NSDate alloc] init];
    NSCalendar* gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSUInteger unitFlags = NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekCalendarUnit;
    
    NSDateComponents* components = [gregorian components:unitFlags fromDate:date toDate:currentDate options:0];
    
    NSInteger weeks = [components week];
    
    int numberOFWeeks = weeks;
    
    return numberOFWeeks;
}


- (IBAction)onClick:(id)sender {
    NSLog(@"Inside search");
    self.isFiltered = true;
    [self.filterMouseDetails removeAllObjects];
    self.filterMouseDetails = [[NSMutableArray alloc] init];
    
    NSString *searchText = self.txtSearch.text;
    float slider1 = self.slider.value;
    float slider2 = self.slider2.value;
    NSArray *ageRange = [NSArray arrayWithObjects:[NSNumber numberWithInt:slider1],[NSNumber numberWithInt:slider2],nil];
    
    
    Rack *tmprack = [[Rack alloc] init];
	
    NSArray *racks = [tmprack getAllRacks:[self managedObjectContext]];
    
    NSMutableArray *eachSection = [[NSMutableArray alloc]init];
    
    self.allMouseDetails = [[NSMutableArray  alloc]init];
    
    self.sectionTitles = [[NSMutableArray alloc] init];
    
    NSArray *labelArray = [[NSArray alloc] initWithObjects:@"A",@"B",@"C",@"D",@"E",@"F",@"G", nil];
    
    for(RackDetails *rack in racks) {
        NSString *racktitle = rack.rack_name;
        for (CageDetails *cage in rack.cages) {
            
            NSString *cageName = @"";
            
            NSNumber *column = [NSNumber numberWithFloat:([cage.column_id floatValue] - [[ NSNumber numberWithInt:1] floatValue] )];
            
            if (cage.cage_name != nil) {
                cageName = cage.cage_name;
            }else{
                cageName = [NSString stringWithFormat:@"%@:%d",[labelArray objectAtIndex:[column intValue]], [cage.row_id intValue]];
            }
            
            for (MouseDetails *mouse in cage.mouseDetails) {
                
                if([[mouse genotypes] containsObject:genotype ] &&
                   ([self getWeeksFromDate:mouse.birth_date]>=[[ageRange firstObject] integerValue] && [self getWeeksFromDate:mouse.birth_date]<=[[ageRange lastObject] integerValue])
                   && [mouse.mouse_name rangeOfString:searchText].location != NSNotFound)
                {
                    [eachSection addObject:mouse];
                    
                }
            }
            if ([eachSection count] != 0) {
                
                [self.allMouseDetails addObject:eachSection];
                [self.sectionTitles addObject:[NSString stringWithFormat:@"Rack : %@ - Cage : %@", racktitle, cageName]];
            }
            
            eachSection = [[NSMutableArray alloc]init];
        }
        
    }
    
    Mouse *mouse = [[Mouse alloc] init];
    
    NSArray *deceasedMouse = [mouse getAllDeceasedMice: [self managedObjectContext]];
    [self.allMouseDetails addObject:deceasedMouse];
    [self.sectionTitles addObject:[NSString stringWithFormat:@"Deceased Mice"]];
    
    
    self.filterMouseDetails = self.allMouseDetails;
    NSLog(@"Main view controller %@",self.filterMouseDetails);
    
    
    
    
    
    
    
    // Genotype *genotype =
    
 
    SearchMouseSectionsController *sectionView = (SearchMouseSectionsController *)self.childViewControllers.lastObject;
    sectionView.filterMouseDetails = self.filterMouseDetails;
    sectionView.sectionTitles = self.sectionTitles;
    [sectionView.collectionSectionsView reloadData];
    
    
    
}*/
/*
- (IBAction)searchButtonClicked:(id)sender {
}
 
 */





- (IBAction)searchMouseOnButtonClick:(id)sender {


    NSString* mouseName = self.txtSearch.text;
    NSString* gender = [self.genderSegment titleForSegmentAtIndex:self.genderSegment.selectedSegmentIndex];
    
    NSArray *ageRange = [NSArray arrayWithObjects:[NSNumber numberWithInt:self.slider.value],[NSNumber numberWithInt:self.slider2.value],nil];

    NSString* genotype;
    
    
   if([self.btnChooseGenotype.currentTitle isEqual:@"Select"])
   {
       genotype = @"";
   }
   else
    {
        genotype = self.btnChooseGenotype.currentTitle;
    }
  
    
    Mouse* tempMouse = [[Mouse alloc]init];
    
    NSArray* miceResult = [tempMouse miceResult:[self managedObjectContext] mouseName:mouseName gender:gender genotype:genotype weekRange:ageRange];
    
    
    NSArray* miceDeceasedResult = [tempMouse miceResultDeceased:[self managedObjectContext] mouseName:mouseName gender:gender genotype:genotype weekRange:ageRange];
    
    [self.allMouseDetails removeAllObjects];
    [self.allMouseDetails addObjectsFromArray:miceResult];
    
    [self.allDeceasedMouseDetails removeAllObjects];
    [self.allDeceasedMouseDetails addObjectsFromArray:miceDeceasedResult];
    
    
    //now pass it to the container and reload the container
    
    if([self.delegate respondsToSelector:@selector(reloadDetails:allDeceasedMouseDetails:)])
    {
        [self.delegate reloadDetails:self.allMouseDetails allDeceasedMouseDetails:self.allDeceasedMouseDetails];
    }
    

}



- (IBAction)searchRacksOnButtnClick:(id)sender {
    if(self.searchRacksText.text.length == 0)
    {
        self.isFiltered = NO;
        [self.filteredRacks removeAllObjects];
        [self.filteredRacks addObjectsFromArray:self.allRacks];
    }
    else
    {
        NSLog(@"Text search");
        self.isFiltered = true;
        [self.filteredRacks removeAllObjects];
        self.filteredRacks = [[NSMutableArray alloc] init];
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.rack_name contains[c] %@",self.searchRacksText.text];
        self.filteredRacks = [NSMutableArray arrayWithArray:[self.allRacks filteredArrayUsingPredicate:predicate]];
        
    }
    
    [self.rackCollection reloadData];
    
}


@end
