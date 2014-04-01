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
    
    NSArray *mice = [NSArray array];
    for(int i = 0; i < 5; i++) {
        MouseDetails *mouse = [NSEntityDescription insertNewObjectForEntityForName:@"MouseDetails" inManagedObjectContext:context];
        mouse.mouse_name = [NSString stringWithFormat:@"Mouse %d", i];
     //   mouse.ca
        mice = [mice arrayByAddingObject:mouse];
    }
    
    cage.mouseDetails = [NSSet setWithArray:mice];
    
    // take care of CageEdit View
    [self.CageInfo.layer setCornerRadius:30.0f];
    [self.CageInfo.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [self.CageInfo.layer setBorderWidth:1.5f];
    
    [self.CageName setText:cage.cage_name];
    [self.CageNotes setText:cage.notes];
    
    // Labels
    [self.Label1View.layer setCornerRadius:30.f];
    [self.Label1View.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [self.Label1View.layer setBorderWidth:1.5f];
    //[self.Label1Switch setTintColor:[UIColor redColor]];
    //[self.Label1Switch setOnTintColor:[UIColor redColor]];
    
    [self.Label2View.layer setCornerRadius:30.f];
    [self.Label2View.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [self.Label2View.layer setBorderWidth:1.5f];
    //[self.Label2Switch setTintColor:[UIColor orangeColor]];
    //[self.Label2Switch setOnTintColor:[UIColor orangeColor]];
    
    [self.Label3View.layer setCornerRadius:30.f];
    [self.Label3View.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [self.Label3View.layer setBorderWidth:1.5f];
    //[self.Label3Switch setTintColor:[UIColor yellowColor]];
    //[self.Label3Switch setOnTintColor:[UIColor yellowColor]];
    
    [self.Label4View.layer setCornerRadius:30.f];
    [self.Label4View.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [self.Label4View.layer setBorderWidth:1.5f];
    //[self.Label4Switch setTintColor:[UIColor greenColor]];
    //[self.Label4Switch setOnTintColor:[UIColor greenColor]];
    
    [self.Label5View.layer setCornerRadius:30.f];
    [self.Label5View.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [self.Label5View.layer setBorderWidth:1.5f];
    //[self.Label5Switch setTintColor:[UIColor blueColor]];
    //[self.Label5Switch setOnTintColor:[UIColor blueColor]];
    
    [self.Label6View.layer setCornerRadius:30.f];
    [self.Label6View.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [self.Label6View.layer setBorderWidth:1.5f];
    //[self.Label6Switch setTintColor:[UIColor purpleColor]];
    //[self.Label6Switch setOnTintColor:[UIColor purpleColor]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
