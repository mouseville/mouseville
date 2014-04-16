//
//  CageLabels.h
//  Mouseville
//
//  Created by abhang on 4/15/14.
//  Copyright (c) 2014 CapstoneProject. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class CageDetails;

@interface CageLabels : NSManagedObject

@property (nonatomic, retain) NSString * label_name;
@property (nonatomic, retain) NSNumber * label_order;
@property (nonatomic, retain) CageDetails *cage;

@end
