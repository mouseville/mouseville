//
//  MouseFamilyDetails.h
//  MouseVilleCoreData
//
//  Created by abhang on 3/29/14.
//  Copyright (c) 2014 CapstoneProject. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class MouseDeceasedDetails, MouseDetails;

@interface MouseFamilyDetails : NSManagedObject

@property (nonatomic, retain) NSNumber * child_id;
@property (nonatomic, retain) NSString * notes;
@property (nonatomic, retain) NSNumber * parent_id;
@property (nonatomic, retain) NSSet *mouseDetails;
@property (nonatomic, retain) NSSet *mouseDeceasedDetails;
@end

@interface MouseFamilyDetails (CoreDataGeneratedAccessors)

- (void)addMouseDetailsObject:(MouseDetails *)value;
- (void)removeMouseDetailsObject:(MouseDetails *)value;
- (void)addMouseDetails:(NSSet *)values;
- (void)removeMouseDetails:(NSSet *)values;

- (void)addMouseDeceasedDetailsObject:(MouseDeceasedDetails *)value;
- (void)removeMouseDeceasedDetailsObject:(MouseDeceasedDetails *)value;
- (void)addMouseDeceasedDetails:(NSSet *)values;
- (void)removeMouseDeceasedDetails:(NSSet *)values;

@end
