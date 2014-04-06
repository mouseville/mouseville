				//
//  MouseViewController.h
//  Mouseville
//
//  Created by Abhang Sonawane on 3/25/14.
//  Copyright (c) 2014 CapstoneProject. All rights reserved.
//

#import <UIKit/UIKit.h>
#import  "PopOverViewController.h"
#import "DatePickerViewController.h"

@interface MouseViewController : UIViewController<DropDownDelegate, UIPopoverControllerDelegate>
@property (weak, nonatomic) IBOutlet UIButton *showButton;



- (IBAction)chooseGenotype:(id)sender;

- (IBAction)selectDate:(id)sender;





@property (weak, nonatomic) IBOutlet UIButton *btnChooseGenotype;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnDone;
@property (assign, nonatomic) NSString* rackName;
@property (assign, nonatomic) NSString* cageName;
@property  NSMutableArray* genotypeMutableArray;
@property (weak, nonatomic) IBOutlet UIButton *btnSelectRack;
@property (weak, nonatomic) IBOutlet UIButton *btnSelectCage;
@property (weak, nonatomic) IBOutlet UIButton *btnDate;
@property (weak, nonatomic) IBOutlet UILabel *lblDate;
@property (weak, nonatomic) IBOutlet UITextField *txtMouseName;

@property (weak, nonatomic) IBOutlet UISegmentedControl *segGenderControl;


- (IBAction)selectRack:(id)sender;


- (IBAction)selectCage:(id)sender;
@end
