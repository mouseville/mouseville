//
//  ViewRacksController.m
//  Mouseville
//
//  Created by nayan on 4/2/14.
//  Copyright (c) 2014 CapstoneProject. All rights reserved.
//

#import "ViewRacksController.h"

@interface ViewRacksController ()

@end

@implementation ViewRacksController

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
    self.rackNameLabel.text = self.rackLabel;
    
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
    
    UILabel *label = (UILabel *)[cell viewWithTag:1000];
    label.text = @"";
    
    [cell.layer setBorderWidth:1.0f];
    [cell.layer setBorderColor:[UIColor blackColor].CGColor];
    
    
    if ((indexPath.section )< [rows integerValue] &&
        (indexPath.item < [columns integerValue])) {
        [cell.layer setBackgroundColor:[UIColor whiteColor].CGColor];
    }else{
        [cell.layer setBackgroundColor:[UIColor grayColor].CGColor];
    }
        
    return cell;
}

@end
