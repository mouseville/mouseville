//
//  Labels.h
//  Mouseville
//
//  Created by abhang on 3/24/14.
//  Copyright (c) 2014 CapstoneProject. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class CageDetails;

@interface Labels : NSManagedObject

@property (nonatomic, retain) NSNumber * label_id;
@property (nonatomic, retain) NSString * label_name;
@property (nonatomic, retain) CageDetails *cageDetails;

@end
