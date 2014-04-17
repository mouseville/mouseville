//
//  SearchMouseSectionsController.m
//  Mouseville
//
//  Created by nayan on 4/13/14.
//  Copyright (c) 2014 CapstoneProject. All rights reserved.
//

#import "SearchMouseSectionsController.h"
#import "Rack.h"
#import "RackDetails.h"
#import "EditMouseViewController.h"

@interface SearchMouseSectionsController ()

@end

@implementation SearchMouseSectionsController

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
    //NSManagedObjectContext *context = [self managedObjectContext];
    
    
    UILongPressGestureRecognizer *lpr = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(didLongPressCellToDelete:)];
    
    lpr.minimumPressDuration = .5;
    lpr.delegate = self;
    
    [self.collectionSectionsView addGestureRecognizer:lpr];
    
    [self.collectionSectionsView reloadData];

    
    self.sectionTitles = [[NSMutableArray alloc] init];
    
    self.sectionMouseDetails = [[NSMutableArray alloc]init];
    
    [self setUpCollectionViewSections];
    
}


-(void) setUpCollectionViewSections
{
    Rack *tmprack = [[Rack alloc] init];
	
    NSArray *racks = [tmprack getAllRacks:[self managedObjectContext]];
    
    NSMutableArray *eachSection = [[NSMutableArray alloc]init];
    
    //self.allMouseDetails = [[NSMutableArray  alloc]init];
    
    
    
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
            
            //for (MouseDetails *mouse in cage.mouseDetails) {
            //NSLog(@"Mouse %@",mouse.mouse_name);
            
            for(MouseDetails* individualMouse in self.allMouseDetails)
            {
                if([individualMouse.cage_id intValue]==  [cage.cage_id intValue] && [individualMouse.cageDetails.rack_id intValue] == [rack.rack_id intValue] )
                    [eachSection addObject:individualMouse];
                
            }
            
            
            if ([eachSection count] != 0) {
                
                [self.sectionMouseDetails addObject:eachSection];
                [self.sectionTitles addObject:[NSString stringWithFormat:@"Rack : %@ - Cage : %@", racktitle, cageName]];
            }
            
            //eachSection
            eachSection = [[NSMutableArray alloc]init];
        }
        
    }
    
    //Mouse *mouse = [[Mouse alloc] init];
    
    //NSArray *deceasedMouse = [mouse getAllDeceasedMice: [self managedObjectContext]];
    //if([deceasedMouse count] != 0){
    
    if([self.allDeceasedMouseDetails count]!=0)
    {
        [self.sectionMouseDetails addObject:[NSArray arrayWithArray:self.allDeceasedMouseDetails]];
        [self.sectionTitles addObject:[NSString stringWithFormat:@"Deceased Mice"]];
    }
    
    //}
    UICollectionViewFlowLayout *collectionViewLayout = (UICollectionViewFlowLayout *)self.collectionSectionsView.collectionViewLayout;
    
    collectionViewLayout.sectionInset = UIEdgeInsetsMake(20, 0, 20, 0);
    

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return [self.sectionMouseDetails count];
    //	return [self.sectionTitles count];
}


-(NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return [[self.sectionMouseDetails objectAtIndex:section] count];
}

-(UICollectionViewCell*) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MCell" forIndexPath:indexPath];
    
    NSString *labelName = ((MouseDetails *)[[self.sectionMouseDetails objectAtIndex:indexPath.section] objectAtIndex:indexPath.item]).mouse_name;
    
    UILabel *label = (UILabel *) [cell viewWithTag:11];
    label.text = [NSString stringWithFormat:@"%@",labelName];

    return cell;
}


//-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
//    
//    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MCell" forIndexPath:indexPath];
//    
//    NSString *labelName = ((MouseDetails *)[[self.sectionMouseDetails objectAtIndex:indexPath.section] objectAtIndex:indexPath.item]).mouse_name;
//    
//    UILabel *label = (UILabel *) [cell viewWithTag:11];
//    label.text = [NSString stringWithFormat:@"%@",labelName];
//    
//   // NSLog(@"LAbel %@",label.text);
//    
//    //UIImageView *image = (UIImageView *)[cell viewWithTag:12];
//    //image.image = [UIImage imageNamed:self]
//    
//    //[cell.layer setBorderWidth:1.0f];
//    //[cell.layer setBorderColor:[UIColor blackColor].CGColor];
//    
//    
//    return cell;
//}


-(NSManagedObjectContext*) managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication]delegate];
    if([delegate performSelector:@selector(managedObjectContext)])
    {
        context = [delegate managedObjectContext];
    }
    
    return context;
}


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview = nil;
    
    if (kind == UICollectionElementKindSectionHeader) {
        MouseCollectionHeader *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
        
           NSString *title = [self.sectionTitles objectAtIndex:indexPath.section];
        
           headerView.sectionName.text = title;

        
        reusableview = headerView;
       }
    
    return reusableview;
}




- (IBAction)didLongPressCellToDelete:(UILongPressGestureRecognizer*)gesture {
    CGPoint tapLocation = [gesture locationInView:self.collectionSectionsView];
    NSIndexPath *indexPath = [self.collectionSectionsView indexPathForItemAtPoint:tapLocation];
    if (indexPath && gesture.state == UIGestureRecognizerStateBegan) {
        NSLog(@"image with index %d to be deleted", indexPath.item);
        
        
        self.deleteMouse = (MouseDetails *)[[self.sectionMouseDetails objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
        
        NSLog(@" deceased %@",self.deleteMouse.is_deceased);
        
        if ([self.deleteMouse.is_deceased isEqualToString:@"Yes"]) {
            UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"Failure" message:@"Mouse already deceased" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            
        }else{
            
            UIAlertView *deleteAlert = [[UIAlertView alloc]
                                        initWithTitle:@"Delete?"
                                        message:@"Are you sure you want to mark this mouse deceased?"
                                        delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Yes", nil];
            [deleteAlert show];
        }
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"passToEachMouse"]){
        EditMouseViewController *editMouse = (EditMouseViewController *)segue.destinationViewController;
        NSIndexPath *indexPath = [[self.collectionSectionsView indexPathsForSelectedItems] objectAtIndex:0];
        MouseDetails *mouseDetails = (MouseDetails *)[[self.sectionMouseDetails objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
        
        
        editMouse.mouse = mouseDetails;
    }
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSLog(@"selected button index = %d", buttonIndex);
    if (buttonIndex == 1) {
        // Do what you need to do to delete the cell
        Mouse *mouse = [[Mouse alloc] init];
        NSManagedObjectContext *context = [self managedObjectContext];
        
        
        if ([mouse markMousedDeceased:context mouseDetails:self.deleteMouse]) {
            UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"Success" message:@"Mouse has been marked deceased" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
        else{
            
            UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"ERROR!" message:@"Error deleting mouse!!!" delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
            [alert show];
            
        }
        
    }
}

//get latest mice details and reload the data


-(void)reloadDetails:(NSMutableArray *)allMouseDetails allDeceasedMouseDetails:(NSMutableArray *)allDeceasedMouseDetails


{
    [self.sectionTitles removeAllObjects];
    [self.sectionMouseDetails removeAllObjects];
    
    [self.allMouseDetails removeAllObjects];
    [self.allDeceasedMouseDetails removeAllObjects];
    
    [self.allMouseDetails addObjectsFromArray:allMouseDetails];
    [self.allDeceasedMouseDetails addObjectsFromArray:allDeceasedMouseDetails];
    
    
    
    [self setUpCollectionViewSections];
    
    [self.collectionSectionsView reloadData];
    
}


@end
