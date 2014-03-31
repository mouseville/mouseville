//
//  RackController.m
//  Mouseville
//
//  Created by nayan on 3/29/14.
//  Copyright (c) 2014 CapstoneProject. All rights reserved.
//

#import "RackController.h"


@implementation RackController



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
    
  //  self.rowStepper.wraps=YES;
    
    self.rowStepper.minimumValue = 1;
    self.rowStepper.maximumValue = 10;
    //  self.rowStepper.autorepeat=YES;
    
    
    
    NSUInteger numberOfRows = self.rowStepper.value;
    self.rowLabel.text = [NSString stringWithFormat:@"%2d", numberOfRows];
    
    
    self.columnStepper.minimumValue = 1;
    self.columnStepper.maximumValue = 7;
    NSUInteger numberOfColumns = self.columnStepper.value;
    self.columnLabel.text = [NSString stringWithFormat:@"%2d", numberOfColumns];
    
    
    //self.delegate = self;

}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onRowChange:(UIStepper *)sender {
    NSUInteger numberOfRow  = sender.value;
    self.rowLabel.text = [NSString stringWithFormat:@"%2d", numberOfRow];
    
    [self.tableCollection reloadData];
}

- (IBAction)onColumnAction:(UIStepper *)sender {
    
    NSUInteger numberOfColumns = self.columnStepper.value;
    self.columnLabel.text = [NSString stringWithFormat:@"%2d", numberOfColumns];
    [self.tableCollection reloadData];
}

-(NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    NSInteger counter = self.rowStepper.value ;
    return counter;
}


-(NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    NSInteger numberRows = self.columnStepper.value;
    
    return numberRows;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    UILabel *label = (UILabel *) [cell viewWithTag:2];
    label.text = @"";
    
   [cell.layer setBorderWidth:1.0f];
  [cell.layer setBorderColor:[UIColor blackColor].CGColor];
    
    
    return cell;
}

@end
