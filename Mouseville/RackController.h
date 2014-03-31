//
//  RackController.h
//  Mouseville
//
//  Created by nayan on 3/29/14.
//  Copyright (c) 2014 CapstoneProject. All rights reserved.
//

#import <UIKit/UIKit.h>

//@protocol stepperDelegate

//-(void) didClickStepper : (double) value1 :(double) value2;

//@end

@interface RackController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate>


@property (weak, nonatomic) IBOutlet UILabel *rowLabel;
@property (weak, nonatomic) IBOutlet UILabel *columnLabel;

@property (weak, nonatomic) IBOutlet UIStepper *rowStepper;

@property (weak, nonatomic) IBOutlet UIStepper *columnStepper;
@property (weak, nonatomic) IBOutlet UICollectionView *tableCollection;

- (IBAction)onRowChange:(UIStepper *)sender;
- (IBAction)onColumnAction:(UIStepper *)sender;


//@property (nonatomic, assign) id<stepperDelegate> delegate;

@end
