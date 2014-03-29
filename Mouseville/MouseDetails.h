//
//  MouseDetails.h
//  Mouseville
//
//  Created by abhang on 3/24/14.
//  Copyright (c) 2014 CapstoneProject. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class CageDetails, Genotype, MouseFamilyDetails;

@interface MouseDetails : NSManagedObject

@property (nonatomic, retain) NSDate * birth_date;
@property (nonatomic, retain) NSNumber * cage_id;
@property (nonatomic, retain) NSString * cage_name;
@property (nonatomic, retain) NSString * gender;
@property (nonatomic, retain) NSString * is_deceased;
@property (nonatomic, retain) NSNumber * mouse_id;
@property (nonatomic, retain) NSString * mouse_name;
@property (nonatomic, retain) NSSet *genotypes;
@property (nonatomic, retain) MouseFamilyDetails *miceFamilyDetails;
@property (nonatomic, retain) CageDetails *cageDetails;
@end

@interface MouseDetails (CoreDataGeneratedAccessors)

- (void)addGenotypesObject:(Genotype *)value;
- (void)removeGenotypesObject:(Genotype *)value;
- (void)addGenotypes:(NSSet *)values;
- (void)removeGenotypes:(NSSet *)values;

@end
