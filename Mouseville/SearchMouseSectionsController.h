//
//  SearchMouseSectionsController.h
//  Mouseville
//
//  Created by nayan on 4/13/14.
//  Copyright (c) 2014 CapstoneProject. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MouseCollectionHeader.h"
#import "Mouse.h"
#import "MainViewController.h"

@interface SearchMouseSectionsController : UIViewController<UICollectionViewDataSource, UICollectionViewDelegate, UIGestureRecognizerDelegate ,MainViewControllerDelegate>

@property (nonatomic, retain) NSMutableArray *allMouseDetails;
@property (nonatomic, retain) NSMutableArray *allDeceasedMouseDetails;

@property (nonatomic, retain) NSMutableArray *sectionMouseDetails;

@property (nonatomic, retain) NSMutableArray *sectionTitles;

@property (strong, nonatomic) IBOutlet UICollectionView *collectionSectionsView;


@property (nonatomic) MouseDetails *deleteMouse;

@end
