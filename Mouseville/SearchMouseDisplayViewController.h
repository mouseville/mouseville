//
//  SearchMouseDisplayViewController.h
//  Mouseville
//
//  Created by shnee on 4/12/14.
//  Copyright (c) 2014 CapstoneProject. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Rack.h"
#import "Cage.h"

@interface SearchMouseDisplayViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) NSMutableArray *sections;

@end
