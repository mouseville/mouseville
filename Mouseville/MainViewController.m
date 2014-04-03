//
//  ViewController.m
//  Mouseville
//
//  Created by Mouseville Team on 2/15/14.
//  Copyright (c) 2014 CapstoneProject. All rights reserved.
//

#import "MainViewController.h"
#import "Rack.h"

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
    
<<<<<<< HEAD
    Rack* rack = [[Rack alloc]init];
    
    self.allRacks = [rack getAllRacks:[self managedObjectContext]];
    
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
    [label setText:[[self.allRacks objectAtIndex:indexPath.row]rack_name]];
    return cell;
    
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.allRacks count];
=======
    
    
>>>>>>> neha_branch
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)createMice:(id)sender {
}

- (IBAction)segmentedValueChanged:(UISegmentedControl *)sender {
    switch (sender.selectedSegmentIndex) {
        case 0:
            self.rackView.hidden=NO;
            self.miceView.hidden= YES;
            break;
        case 1:
            self.rackView.hidden=YES;
            self.miceView.hidden= NO;
            break;
            
        default:
            break;
    }
}
@end
