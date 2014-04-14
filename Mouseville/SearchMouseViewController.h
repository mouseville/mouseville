//
//  SearchMouseViewController.h
//  Mouseville
//
//  Created by Abhang Sonawane on 3/29/14.
//  Copyright (c) 2014 CapstoneProject. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PopOverViewController.h"

@interface SearchMouseViewController : UIViewController<DropDownDelegate, UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UISlider *slider;
- (IBAction)sliderValueChanged:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UIButton *btnChooseGenotype;
- (IBAction)chooseGenotype:(id)sender;


@property (weak, nonatomic) IBOutlet UITextField *txtSearch;

@property (weak, nonatomic) IBOutlet UISlider *slider2;


- (IBAction)slider2ValueChanged:(id)sender;

@property (nonatomic, copy) NSNumber *minAge;
@property (nonatomic, copy) NSNumber *maxAge;
@property NSMutableArray* genotypeMutableArray;

@property (weak, nonatomic) IBOutlet UITableView *searchMouseTable;


@end
