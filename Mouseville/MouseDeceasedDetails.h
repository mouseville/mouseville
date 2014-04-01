//
//  MouseDeceasedDetails.h
//  MouseVilleCoreData
//
//  Created by abhang on 3/29/14.
//  Copyright (c) 2014 CapstoneProject. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Genotype, MouseFamilyDetails;

@interface MouseDeceasedDetails : NSManagedObject

@property (nonatomic, retain) NSDate * birth_date;
@property (nonatomic, retain) NSNumber * cage_id;
@property (nonatomic, retain) NSString * cage_name;
@property (nonatomic, retain) NSString * gender;
@property (nonatomic, retain) NSString * is_deceased;
@property (nonatomic, retain) NSNumber * mouse_id;
@property (nonatomic, retain) NSString * mouse_name;
@property (nonatomic, retain) NSSet *genotype;
@property (nonatomic, retain) NSSet *miceFamilyDetails;
@end

@interface MouseDeceasedDetails (CoreDataGeneratedAccessors)

- (void)addGenotypeObject:(Genotype *)value;
- (void)removeGenotypeObject:(Genotype *)value;
- (void)addGenotype:(NSSet *)values;
- (void)removeGenotype:(NSSet *)values;

- (void)addMiceFamilyDetailsObject:(MouseFamilyDetails *)value;
- (void)removeMiceFamilyDetailsObject:(MouseFamilyDetails *)value;
- (void)addMiceFamilyDetails:(NSSet *)values;
- (void)removeMiceFamilyDetails:(NSSet *)values;

@end
