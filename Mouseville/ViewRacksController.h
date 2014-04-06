//
//  ViewRacksController.h
//  Mouseville
//
//  Created by nayan on 4/2/14.
//  Copyright (c) 2014 CapstoneProject. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RackDetails.h"

@interface ViewRacksController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *viewRackCollection;

@property (nonatomic) RackDetails *viewRackDetails;

@property (nonatomic) NSString *rackLabel;

@property (weak, nonatomic) IBOutlet UILabel *rackNameLabel;

@end
