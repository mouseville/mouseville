//
//  ViewRacksController.m
//  Mouseville
//
//  Created by nayan on 4/2/14.
//  Copyright (c) 2014 CapstoneProject. All rights reserved.
//

#import "ViewRacksController.h"
#import "CageViewController.h"
#import "Rack.h"
#import "Cage.h"


@interface ViewRacksController ()

@end

@implementation ViewRacksController

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
       // self.rackNameLabel.text = self.rackLabel;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
   // self.rackNameLabel.text = self.rackLabel;
    
    self.title =self.rackLabel;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 10;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 7;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"RCell" forIndexPath:indexPath];
    
    NSNumber *columns = self.viewRackDetails.number_columns;
    
    NSNumber *rows = self.viewRackDetails.number_rows;
    
    NSString *labelText = @" ";
    for (int count=0; count<self.cageDetailsForRack.count; count++)
    {
        
        CageDetails *cageDetail = (CageDetails *)self.cageDetailsForRack[count];
        if ([cageDetail.row_id integerValue]== (indexPath.section +1)
            && [cageDetail.column_id integerValue] == (indexPath.item +1)) {
            labelText = [NSString stringWithFormat:@"%@",cageDetail.cage_id];
            break;
        }
    }
    
    [cell.layer setBorderWidth:1.0f];
    [cell.layer setBorderColor:[UIColor blackColor].CGColor];
    
    
    if ((indexPath.section )< [rows integerValue] &&
        (indexPath.item < [columns integerValue])) {
        [cell.layer setBackgroundColor:[UIColor whiteColor].CGColor];
        UIButton *button = (UIButton *)[cell viewWithTag:5];
        [button setEnabled:YES];
        UILabel *label = (UILabel *)[cell viewWithTag:4];
        label.text = labelText;
    }else{
        [cell.layer setBackgroundColor:[UIColor groupTableViewBackgroundColor].CGColor];
        UIButton *button = (UIButton *)[cell viewWithTag:5];
        [button setEnabled:NO];
        UILabel *label = (UILabel *)[cell viewWithTag:4];
        label.text = labelText;
    }
        
    return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"showCageDetails"]){
        NSManagedObjectContext *context = [self managedObjectContext];
        
        
        UICollectionViewCell *cel = (UICollectionViewCell *)[[sender superview] superview];
        
        UILabel *lab = (UILabel *)[cel.contentView viewWithTag:4];
        
        NSNumber* cageId = [NSNumber numberWithInt:[lab.text intValue]];
        
        
        Cage* cage = [[Cage alloc] init];
        
        RackDetails *rackDetailss = self.viewRackDetails;
        CageDetails *cageDetailss = [cage getParticularCage:context rackId:rackDetailss.rack_id cageId:cageId];
        
       
        CageViewController *viewCageController = (CageViewController *)segue.destinationViewController;
        viewCageController.cage = cageDetailss;
    }
}
@end
