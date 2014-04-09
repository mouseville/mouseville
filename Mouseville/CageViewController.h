//
//  CageViewController.h
//  Mouseville
//
//  Created by shnee on 3/29/14.
//  Copyright (c) 2014 CapstoneProject. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CageDetails.h"

@interface CageViewController : UIViewController <UITextFieldDelegate, UITableViewDelegate>

@property (strong, nonatomic) CageDetails *cage;

@property (weak, nonatomic) IBOutlet UILabel *NumCagesLabel;
@property (weak, nonatomic) IBOutlet UIView *CageInfo;
@property (weak, nonatomic) IBOutlet UITextField *cageName;
@property (weak, nonatomic) IBOutlet UITextView *CageNotes;

@property (weak, nonatomic) IBOutlet UIView *mouseListContainter;


// Labels
@property (weak, nonatomic) IBOutlet UIView *Label1View;
@property (weak, nonatomic) IBOutlet UISwitch *Label1Switch;
@property (weak, nonatomic) IBOutlet UILabel *Label1;

@property (weak, nonatomic) IBOutlet UIView *Label2View;
@property (weak, nonatomic) IBOutlet UISwitch *Label2Switch;
@property (weak, nonatomic) IBOutlet UILabel *Label2;

@property (weak, nonatomic) IBOutlet UIView *Label3View;
@property (weak, nonatomic) IBOutlet UISwitch *Label3Switch;
@property (weak, nonatomic) IBOutlet UILabel *Label3;

@property (weak, nonatomic) IBOutlet UIView *Label4View;
@property (weak, nonatomic) IBOutlet UISwitch *Label4Switch;
@property (weak, nonatomic) IBOutlet UILabel *Label4;

@property (weak, nonatomic) IBOutlet UIView *Label5View;
@property (weak, nonatomic) IBOutlet UISwitch *Label5Switch;
@property (weak, nonatomic) IBOutlet UILabel *Label5;

@property (weak, nonatomic) IBOutlet UIView *Label6View;
@property (weak, nonatomic) IBOutlet UISwitch *Label6Switch;
@property (weak, nonatomic) IBOutlet UILabel *Label6;

@property (nonatomic) CageDetails *particularCageDetails;
@property (nonatomic) RackDetails *particularRackDetails;
@end
