//
//  SearchMouseViewController.h
//  Mouseville
//
//  Created by Abhang Sonawane on 3/29/14.
//  Copyright (c) 2014 CapstoneProject. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PopOverViewController.h"

@interface SearchMouseViewController : UIViewController<DropDownDelegate>
@property (weak, nonatomic) IBOutlet UISlider *slider;
- (IBAction)sliderValueChanged:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UIButton *chooseGenotype;
- (IBAction)chooseGenotype:(id)sender;



@end
