//
//  PopOverViewController.m
//  Mouseville
//
//  Created by Abhang Sonawane on 3/29/14.
//  Copyright (c) 2014 CapstoneProject. All rights reserved.
//

#import "PopOverViewController.h"

@interface PopOverViewController ()

@end

@implementation PopOverViewController


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

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.arrData count ];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if(!cell){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    
    [cell.textLabel setText:[self.arrData objectAtIndex:indexPath.row]];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
 
    UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
    self.selectedValue = selectedCell.textLabel.text;
   [self.delegate didClickDropdown:[self.arrData objectAtIndex:indexPath.row] popoverIdentifier:self.identifier ] ;
    
    
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* deselectedCell = [tableView cellForRowAtIndexPath:indexPath];
    self.selectedValue = deselectedCell.textLabel.text;
    [self.delegate didDeSelectClickDropdown:[self.arrData objectAtIndex:indexPath.row] popoverIdentifier:self.identifier];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [self.delegate dropDownWillDisappear:self.identifier];
}


@end
