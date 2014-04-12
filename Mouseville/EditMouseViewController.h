//
//  EditMouseViewController.h
//  Mouseville
//
//  Created by Abhang Sonawane on 4/5/14.
//  Copyright (c) 2014 CapstoneProject. All rights reserved.
//

#import <UIKit/UIKit.h>
#import  "PopOverViewController.h"
#import "DatePickerViewController.h"
#import "Mouse.h"


@interface EditMouseViewController : UIViewController <DropDownDelegate, UIPopoverControllerDelegate>

@property (weak, nonatomic) IBOutlet UIView *editMouseView;

@property (weak, nonatomic) IBOutlet UILabel *lblDate;
@property (weak, nonatomic) IBOutlet UITextField *txtMouseName;

@property (weak, nonatomic) IBOutlet UISegmentedControl *segMouseGender;

@property (weak, nonatomic) IBOutlet UIButton *btnChooseGenotype;

@property (weak, nonatomic) IBOutlet UIButton *btnDate;


@property (weak, nonatomic) IBOutlet UIButton *btnSelectRack;


@property (weak, nonatomic) IBOutlet UIButton *btnSelectCage;

@property (weak, nonatomic) IBOutlet UISegmentedControl *segMouseDeceased;

@property NSMutableArray* genotypeMutableArray;

@property MouseDetails* mouse;

@end
