//
//  MouseFamilyDetails.h
//  Mouseville
//
//  Created by abhang on 3/24/14.
//  Copyright (c) 2014 CapstoneProject. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class MouseDetails;

@interface MouseFamilyDetails : NSManagedObject

@property (nonatomic, retain) NSNumber * child_id;
@property (nonatomic, retain) NSString * notes;
@property (nonatomic, retain) NSNumber * parent_id;
@property (nonatomic, retain) NSSet *mouseDetails;
@end

@interface MouseFamilyDetails (CoreDataGeneratedAccessors)

- (void)addMouseDetailsObject:(MouseDetails *)value;
- (void)removeMouseDetailsObject:(MouseDetails *)value;
- (void)addMouseDetails:(NSSet *)values;
- (void)removeMouseDetails:(NSSet *)values;

@end
