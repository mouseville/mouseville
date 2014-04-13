//
//  SettingsController.h
//  Mouseville
//
//  Created by nayan on 4/11/14.
//  Copyright (c) 2014 CapstoneProject. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RackDetails.h"

@interface SettingsController : UIViewController


@property (weak, nonatomic) IBOutlet UIImageView *image1;

@property (weak, nonatomic) IBOutlet UIImageView *image2;

@property (weak, nonatomic) IBOutlet UIImageView *image3;


@property (weak, nonatomic) IBOutlet UIImageView *image4;

@property (weak, nonatomic) IBOutlet UIImageView *image5;

@property (weak, nonatomic) IBOutlet UIImageView *image6;
@property (weak, nonatomic) IBOutlet UIView *labelView;

@property(weak, nonatomic) NSString *rackName;

- (IBAction)saveLabels:(id)sender;


- (IBAction)exportToCSV:(id)sender;


@property (weak, nonatomic) IBOutlet UITextField *label2;


@property (weak, nonatomic) IBOutlet UITextField *label3;


@property (weak, nonatomic) IBOutlet UITextField *label4;


@property (weak, nonatomic) IBOutlet UITextField *label1;

@property (weak, nonatomic) IBOutlet UITextField *label5;


@property (weak, nonatomic) IBOutlet UITextField *label6;



@end
