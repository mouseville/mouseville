//
//  DatePickerViewController.h
//  Mouseville
//
//  Created by Abhang Sonawane on 3/31/14.
//  Copyright (c) 2014 CapstoneProject. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DatePickerDelegate
-(void)didClickDatePick:(NSString*) string;
@end

@interface DatePickerViewController : UIViewController

@property (nonatomic, assign) id<DatePickerDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

- (IBAction)datePicked:(UIDatePicker *)sender;

@end
