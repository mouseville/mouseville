//
//  CageDetails.h
//  Mouseville
//
//  Created by abhang on 3/24/14.
//  Copyright (c) 2014 CapstoneProject. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Labels, MouseDetails, RackDetails;

@interface CageDetails : NSManagedObject

@property (nonatomic, retain) NSNumber * cage_id;
@property (nonatomic, retain) NSNumber * column_id;
@property (nonatomic, retain) NSString * notes;
@property (nonatomic, retain) NSString * cage_name;
@property (nonatomic, retain) NSNumber * rack_id;
@property (nonatomic, retain) NSNumber * row_id;
@property (nonatomic, retain) NSSet *labels;
@property (nonatomic, retain) NSSet *mouseDetails;
@property (nonatomic, retain) RackDetails *rackDetails;
@end

@interface CageDetails (CoreDataGeneratedAccessors)

- (void)addLabelsObject:(Labels *)value;
- (void)removeLabelsObject:(Labels *)value;
- (void)addLabels:(NSSet *)values;
- (void)removeLabels:(NSSet *)values;

- (void)addMouseDetailsObject:(MouseDetails *)value;
- (void)removeMouseDetailsObject:(MouseDetails *)value;
- (void)addMouseDetails:(NSSet *)values;
- (void)removeMouseDetails:(NSSet *)values;

@end
