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

@interface MouseListViewController : UIViewController <UITableViewDataSource,UITableViewDelegate,DropDownDelegate>

@property (strong, nonatomic) NSSet *mice;
@property (strong, nonatomic) NSArray *miceArray;

@end
