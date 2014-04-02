//
//  MouseListViewController.h
//  Mouseville
//
//  Created by shnee on 4/1/14.
//  Copyright (c) 2014 CapstoneProject. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MouseDetails.h"

@interface MouseListViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) NSSet *mice;
@property (strong, nonatomic) NSArray *miceArray;

@end
