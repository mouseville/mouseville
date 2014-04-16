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
#import "SettingsController.h"


@interface ViewRacksController () {
    NSArray *colors;
}

@end

@implementation ViewRacksController

-(void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.viewRackCollection reloadData];
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
    
    colors = [NSArray arrayWithObjects:[UIColor redColor],[UIColor orangeColor],[UIColor yellowColor],[UIColor greenColor],[UIColor blueColor],[UIColor purpleColor],nil];
    
    
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
    
    UICollectionViewCell *cell;
    if ((indexPath.section )< [rows integerValue] &&
        (indexPath.item < [columns integerValue])) {
        
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"RCell" forIndexPath:indexPath];
        [cell.layer setBorderWidth:1.0f];
        [cell.layer setBorderColor:[UIColor blackColor].CGColor];
        
        [cell.layer setBackgroundColor:[UIColor whiteColor].CGColor];
        UIButton *button = (UIButton *)[cell viewWithTag:5];
        [button setEnabled:YES];
        UILabel *label = (UILabel *)[cell viewWithTag:4];
        label.text = labelText;
        
        CageDetails *cage = [Rack getCageFromRack:self.viewRackDetails withRow:indexPath.section + 1 withColumn:indexPath.row + 1];
        
        // set icon for cell
        UIImageView *bg_img;
        if ([Cage getBreedingStatus:cage] == MALE_ONLY) {
            bg_img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"male-75"]];
        } else if ([Cage getBreedingStatus:cage] == FEMALE_ONLY) {
            bg_img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"female-75"]];
        } else if ([Cage getBreedingStatus:cage] == BREEDING) {
            bg_img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"male_female-75"]];
        } else {
            bg_img = [[UIImageView alloc] init];
            
        }
        
        UILabel *label1 = (UILabel *)[cell viewWithTag:11];
        UILabel *label2 = (UILabel *)[cell viewWithTag:12];
        UILabel *label3 = (UILabel *)[cell viewWithTag:13];
        UILabel *label4 = (UILabel *)[cell viewWithTag:14];
        UILabel *label5 = (UILabel *)[cell viewWithTag:15];
        UILabel *label6 = (UILabel *)[cell viewWithTag:16];
        
        if (cage.label1) {
            [label1 setBackgroundColor:[UIColor redColor]];
        } else {
            [label1 setBackgroundColor:[UIColor whiteColor]];
        }
        if (cage.label2) {
            [label2 setBackgroundColor:[UIColor orangeColor]];
        } else {
            [label2 setBackgroundColor:[UIColor whiteColor]];
        }
        if (cage.label3) {
            [label3 setBackgroundColor:[UIColor yellowColor]];
        } else {
            [label3 setBackgroundColor:[UIColor whiteColor]];
        }
        if (cage.label4) {
            [label4 setBackgroundColor:[UIColor greenColor]];
        } else {
            [label4 setBackgroundColor:[UIColor whiteColor]];
        }
        if (cage.label5) {
            [label5 setBackgroundColor:[UIColor blueColor]];
        } else {
            [label5 setBackgroundColor:[UIColor whiteColor]];
        }
        if (cage.label6) {
            [label6 setBackgroundColor:[UIColor purpleColor]];
        } else {
            [label6 setBackgroundColor:[UIColor whiteColor]];
        }
        
        cell.backgroundView = bg_img;
        
    }else{
        
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"disabled" forIndexPath:indexPath];
        [cell.layer setBorderWidth:1.0f];
        [cell.layer setBorderColor:[UIColor blackColor].CGColor];
        
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
    }else if ([segue.identifier isEqualToString:@"rackSettingsSegue"]){
        SettingsController *settings = (SettingsController *)segue.destinationViewController;
        settings.rackDetails = self.viewRackDetails;
    }
}
@end
