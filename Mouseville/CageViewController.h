//
//  CageViewController.h
//  Mouseville
//
//  Created by shnee on 3/29/14.
//  Copyright (c) 2014 CapstoneProject. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CageViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *NumCagesLabel;
@property (weak, nonatomic) IBOutlet UIView *CageInfo;
@property (weak, nonatomic) IBOutlet UILabel *CageName;

@property (weak, nonatomic) IBOutlet UITextView *CageNotes;

@end
