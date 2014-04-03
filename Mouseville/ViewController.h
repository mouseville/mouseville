//
//  ViewController.h
//  Mouseville
//
//  Created by abhang on 3/25/14.
//  Copyright (c) 2014 CapstoneProject. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CageDetails.h"
#import "MouseDetails.h"

@interface ViewController : UIViewController

@property (strong, nonatomic) CageDetails *cage;
@property (weak, nonatomic) IBOutlet UILabel *Label;
@property (weak, nonatomic) IBOutlet UIButton *CageButton;
- (IBAction)PushCageButton:(id)sender;

@end
