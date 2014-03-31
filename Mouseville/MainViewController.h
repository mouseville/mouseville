//
//  ViewController.h
//  Mouseville
//
//  Created by Mouseville Team on 2/15/14.
//  Copyright (c) 2014 CapstoneProject. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *miceView;
@property (weak, nonatomic) IBOutlet UIView *rackView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedBar;

- (IBAction)createMice:(id)sender;

- (IBAction)segmentedValueChanged:(id)sender;




@end
