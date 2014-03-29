//
//  ViewController.m
//  Mouseville
//
//  Created by abhang on 3/25/14.
//  Copyright (c) 2014 CapstoneProject. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "UserDetails.h"


@interface ViewController ()

@end

@implementation ViewController


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
    NSEntityDescription* userDetailsEntity = [NSEntityDescription entityForName:@"UserDetails" inManagedObjectContext:context];
    NSFetchRequest* fetchRequest = [[NSFetchRequest alloc]init];
    [fetchRequest setEntity:userDetailsEntity];
    
    NSError *error = nil;
    
    NSArray* user = [context executeFetchRequest:fetchRequest error:&error];
    
    if(error)
    {
        NSLog(@"Error fetching user details: %@ %@",error,[error localizedDescription]);
        return;
    }
    
    
    if([user count] == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Hello" message:@"Please let us know your name" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        alert.alertViewStyle = UIAlertViewStylePlainTextInput;
        [alert show];
        
    }
    
}

-(void)alertView:(UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSManagedObjectContext *context = [self managedObjectContext];
    UserDetails *userDetails = [NSEntityDescription insertNewObjectForEntityForName:@"UserDetails" inManagedObjectContext:context];
    
    userDetails.user_name = [[alertView textFieldAtIndex:0]text];

    
    NSError* error = nil;
    
    if(![context save:&error])
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error" message:[error localizedDescription] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    
    [[self Label]setText:userDetails.user_name];
        
    
    
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
