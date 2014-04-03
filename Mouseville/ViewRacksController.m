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
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
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
    
    UILabel *label = (UILabel *)[cell viewWithTag:1000];
    label.text = @"";
    
    [cell.layer setBorderWidth:1.0f];
    [cell.layer setBorderColor:[UIColor blackColor].CGColor];
    [cell.layer setBackgroundColor:[UIColor grayColor].CGColor];
    
    return cell;
}

@end
