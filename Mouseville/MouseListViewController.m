//
//  MouseListViewController.m
//  Mouseville
//
//  Created by shnee on 4/1/14.
//  Copyright (c) 2014 CapstoneProject. All rights reserved.
//

#import "MouseListViewController.h"

@interface MouseListViewController ()

@end

@implementation MouseListViewController

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mouse"];
    
    UILabel *mouseName = (UILabel *)[cell viewWithTag:132];
    MouseDetails *mouse = [self.miceArray objectAtIndex:indexPath.row];
    mouseName.text = mouse.mouse_name;
    
    UILabel *mouseDesc = (UILabel *)[cell viewWithTag:133];
    mouseDesc.text = @"Genotype / DoB";
    
    return cell;
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
    
    NSLog(@"MouseList viewDidLoad %d mice", [self.mice count]);
    
    self.miceArray = [self.mice allObjects];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
