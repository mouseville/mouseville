//
//  RackDetails.h
//  Mouseville
//
//  Created by abhang on 3/24/14.
//  Copyright (c) 2014 CapstoneProject. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class CageDetails;

@interface RackDetails : NSManagedObject

@property (nonatomic, retain) NSDate * created_date;
@property (nonatomic, retain) NSString * notes;
@property (nonatomic, retain) NSNumber * number_columns;
@property (nonatomic, retain) NSNumber * number_rows;
@property (nonatomic, retain) NSNumber * rack_id;
@property (nonatomic, retain) NSString * rack_name;
@property (nonatomic, retain) NSSet *cages;
@end

@interface RackDetails (CoreDataGeneratedAccessors)

- (void)addCagesObject:(CageDetails *)value;
- (void)removeCagesObject:(CageDetails *)value;
- (void)addCages:(NSSet *)values;
- (void)removeCages:(NSSet *)values;

@end
