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
#import "RackController.h"
@interface MouseViewController : UIViewController<DropDownDelegate, UIPopoverControllerDelegate, UITextFieldDelegate>


- (IBAction)chooseGenotype:(id)sender;


//@property (weak, nonatomic) IBOutlet UIView *createMouseView;


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
@property (nonatomic, assign) id<RackControllerDelegate> delegate;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segGenderControl;

@property (weak, nonatomic) IBOutlet UIButton *btnCreateMouse;

- (IBAction)cancelButtonClick:(id)sender;



- (IBAction)selectRack:(id)sender;


- (IBAction)selectCage:(id)sender;
@end
