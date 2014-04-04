//
//  ManageGenotypesViewController.h
//  Mouseville
//
//  Created by Abhang Sonawane on 4/4/14.
//  Copyright (c) 2014 CapstoneProject. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ManageGenotypesViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *genotypeTableView;

@property (strong, nonatomic) NSMutableArray *genotypes;

- (IBAction)insertNewGenotype:(id)sender;
@end
