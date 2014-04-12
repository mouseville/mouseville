//
//  ViewController.h
//  Mouseville
//
//  Created by Mouseville Team on 2/15/14.
//  Copyright (c) 2014 CapstoneProject. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewRacksController.h"

@interface MainViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate>{
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

@end
