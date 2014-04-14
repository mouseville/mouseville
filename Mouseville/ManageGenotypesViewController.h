//
//  ManageGenotypesViewController.h
//  Mouseville
//
//  Created by Abhang Sonawane on 4/4/14.
//  Copyright (c) 2014 CapstoneProject. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GenotypeLabels.h"
#import "Genotype.h"
#import "GenotypeManager.h"

#import "RackDetails.h"
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>
#import "Rack.h"
#import "RackDetails.h"
#import "CageDetails.h"
#import "MouseDetails.h"
#import "CHCSVParser.h"



@interface ManageGenotypesViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate, MFMailComposeViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *genotypeTableView;
@property (weak, nonatomic) IBOutlet UIView *genesView;

@property (strong, nonatomic) NSMutableArray *genotypes;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnEditBarButton;


- (IBAction)insertNewGenotype:(id)sender;

- (IBAction)exportToCSV:(id)sender;
@end
