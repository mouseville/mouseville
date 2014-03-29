//
//  Genotype.h
//  Mouseville
//
//  Created by abhang on 3/24/14.
//  Copyright (c) 2014 CapstoneProject. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class MouseDetails;

@interface Genotype : NSManagedObject

@property (nonatomic, retain) NSNumber * genotype_id;
@property (nonatomic, retain) NSString * genotype_name;
@property (nonatomic, retain) NSSet *mouseDetails;
@end

@interface Genotype (CoreDataGeneratedAccessors)

- (void)addMouseDetailsObject:(MouseDetails *)value;
- (void)removeMouseDetailsObject:(MouseDetails *)value;
- (void)addMouseDetails:(NSSet *)values;
- (void)removeMouseDetails:(NSSet *)values;

@end
