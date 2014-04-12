//
//  SearchMouseDisplayViewController.m
//  Mouseville
//
//  Created by shnee on 4/12/14.
//  Copyright (c) 2014 CapstoneProject. All rights reserved.
//

#import "SearchMouseDisplayViewController.h"

@interface SearchMouseDisplayViewController ()

@end

@implementation SearchMouseDisplayViewController

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"result"];
    
    UICollectionView *collection = (UICollectionView *)[cell viewWithTag:401];
    
    return cell;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.sections count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100.0;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [self.sections objectAtIndex:section];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSManagedObjectContext *context = [self managedObjectContext];
    
    self.sections = [[NSMutableArray alloc] init];
    
    Rack *tmprack = [[Rack alloc] init];
	
    NSArray *racks = [tmprack getAllRacks:context];
    
    for(RackDetails *rack in racks) {
        NSString *racktitle = rack.rack_name;
        
        for (int row = 0; row < [rack.number_rows intValue]; row++) {
            for (int col = 0; col < [rack.number_columns intValue]; col++) {
                [self.sections addObject:[NSString stringWithFormat:@"%@ - Cage %@%d", racktitle, [Cage numberToAlphabet:[NSNumber numberWithInt:col+1]],row+1]];
            }
        }
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
