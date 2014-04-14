//
//  ViewController.h
//  Mouseville
//
//  Created by Mouseville Team on 2/15/14.
//  Copyright (c) 2014 CapstoneProject. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewRacksController.h"
#import "PopOverViewController.h"
#import "MouseViewController.h"
@interface MainViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate, UITextFieldDelegate, UIGestureRecognizerDelegate, DropDownDelegate>{
    ViewRacksController *viewRacks ;
}
@property (weak, nonatomic) IBOutlet UIView *miceView;
@property (weak, nonatomic) IBOutlet UIView *rackView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedBar;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedController;

- (IBAction)createMice:(id)sender;

- (IBAction)segmentedValueChanged:(id)sender;
@property (weak, nonatomic) IBOutlet UICollectionView *rackCollection;
@property (nonatomic, copy) NSArray* allRacks;


@property (nonatomic, retain) NSMutableArray* filteredRacks;

@property (weak, nonatomic) IBOutlet UITextField *searchRacksText;

@property (assign) BOOL isFiltered;

- (IBAction)segmentedAdd:(id)sender;

@property (nonatomic) NSInteger selectedIndexSegment;

@property (nonatomic) NSString *deleteRackName;


//properties for mouse view

@property (weak, nonatomic) IBOutlet UIView *slideThisView;

@property (weak, nonatomic) IBOutlet UIButton *expandButton;



@property (weak, nonatomic) IBOutlet UISlider *slider;
- (IBAction)sliderValueChanged:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UIButton *btnChooseGenotype;
- (IBAction)chooseGenotype:(id)sender;

- (IBAction)expandClicked:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *txtSearch;

@property (weak, nonatomic) IBOutlet UISlider *slider2;


- (IBAction)slider2ValueChanged:(id)sender;

@property (nonatomic, copy) NSNumber *minAge;
@property (nonatomic, copy) NSNumber *maxAge;
@property NSMutableArray* genotypeMutableArray;

@property (weak, nonatomic) IBOutlet UITableView *searchMouseTable;


@end
