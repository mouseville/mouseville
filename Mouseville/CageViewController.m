//
//  CageViewController.m
//  Mouseville
//
//  Created by shnee on 3/29/14.
//  Copyright (c) 2014 CapstoneProject. All rights reserved.
//

#import "CageViewController.h"
#import "MouseDetails.h"
#import "CageDetails.h"

@interface CageViewController ()

@end

@implementation CageViewController

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
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    NSManagedObjectContext *context = [self managedObjectContext];
    NSEntityDescription* userDetailsEntity = [NSEntityDescription entityForName:@"CageDetails" inManagedObjectContext:context];
    NSFetchRequest* fetchRequest = [[NSFetchRequest alloc]init];
    [fetchRequest setEntity:userDetailsEntity];
    
    NSError *error = nil;
    
    NSArray *cages = [context executeFetchRequest:fetchRequest error:&error];
    
    [self.NumCagesLabel setText:[NSString stringWithFormat:@"%d cages in DB", [cages count]]];
    
    //create a dummy cage with mice
    CageDetails *cage = [NSEntityDescription insertNewObjectForEntityForName:@"CageDetails" inManagedObjectContext:context];
    
    cage.cage_name = @"Test Cage";
    cage.notes = @"This is a test cage";
    
    /*NSSet *mice = [NSSet array];
    for(int i = 0; i < 5; i++) {
        MouseDetails *mouse = [NSEntityDescription insertNewObjectForEntityForName:@"MouseDetails" inManagedObjectContext:context];
        mouse.mouse_name = [NSString stringWithFormat:@"Mouse %d", i];
     //   mouse.ca
        mice = [mice arrayByAddingObject:mouse];
    }*/
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
