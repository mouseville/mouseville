//
//  MouseListViewController.h
//  Mouseville
//
//  Created by shnee on 4/1/14.
//  Copyright (c) 2014 CapstoneProject. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MouseDetails.h"
#import "PopOverViewController.h"
#import "Mouse.h"
#import "Rack.h"
#import "Cage.h"

@interface MouseListViewController : UIViewController <UITableViewDataSource,UITableViewDelegate,DropDownDelegate>

@property (strong, nonatomic) NSArray *miceArray;

@property (strong, nonatomic) NSString *currentCageIndex;
@property (strong, nonatomic) CageDetails *currentCage;
@property (strong, nonatomic) MouseDetails *selectedMouse;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
