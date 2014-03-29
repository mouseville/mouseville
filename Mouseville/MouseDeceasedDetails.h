//
//  MouseDeceasedDetails.h
//  Mouseville
//
//  Created by abhang on 3/25/14.
//  Copyright (c) 2014 CapstoneProject. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Genotype;

@interface MouseDeceasedDetails : NSManagedObject

@property (nonatomic, retain) NSDate * birth_date;
@property (nonatomic, retain) NSNumber * cage_id;
@property (nonatomic, retain) NSString * gender;
@property (nonatomic, retain) NSString * cage_name;
@property (nonatomic, retain) NSString * is_deceased;
@property (nonatomic, retain) NSNumber * mouse_id;
@property (nonatomic, retain) NSString * mouse_name;
@property (nonatomic, retain) NSSet *genotype;
@end

@interface MouseDeceasedDetails (CoreDataGeneratedAccessors)

- (void)addGenotypeObject:(Genotype *)value;
- (void)removeGenotypeObject:(Genotype *)value;
- (void)addGenotype:(NSSet *)values;
- (void)removeGenotype:(NSSet *)values;

@end
