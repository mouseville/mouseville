//
//  SettingsController.h
//  Mouseville
//
//  Created by nayan on 4/11/14.
//  Copyright (c) 2014 CapstoneProject. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RackDetails.h"
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>
#import "Rack.h"
#import "RackDetails.h"
#import "CageDetails.h"
#import "MouseDetails.h"
#import "CHCSVParser.h"


@interface SettingsController : UIViewController<MFMailComposeViewControllerDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *image1;

@property (weak, nonatomic) IBOutlet UIImageView *image2;

@property (weak, nonatomic) IBOutlet UIImageView *image3;


@property (weak, nonatomic) IBOutlet UIImageView *image4;

@property (weak, nonatomic) IBOutlet UIImageView *image5;

@property (weak, nonatomic) IBOutlet UIImageView *image6;
@property (weak, nonatomic) IBOutlet UIView *labelView;

@property(weak, nonatomic) RackDetails *rackDetails;

- (IBAction)saveLabels:(id)sender;





@property (weak, nonatomic) IBOutlet UITextField *label2;


@property (weak, nonatomic) IBOutlet UITextField *label3;


@property (weak, nonatomic) IBOutlet UITextField *label4;


@property (weak, nonatomic) IBOutlet UITextField *label1;

@property (weak, nonatomic) IBOutlet UITextField *label5;


@property (weak, nonatomic) IBOutlet UITextField *label6;



@end
