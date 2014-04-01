//
//  MouseDetails.h
//  MouseVilleCoreData
//
//  Created by abhang on 3/29/14.
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
@property (nonatomic, retain) CageDetails *cageDetails;
@property (nonatomic, retain) NSSet *genotypes;
@property (nonatomic, retain) NSSet *miceFamilyDetails;
@end

@interface MouseDetails (CoreDataGeneratedAccessors)

- (void)addGenotypesObject:(Genotype *)value;
- (void)removeGenotypesObject:(Genotype *)value;
- (void)addGenotypes:(NSSet *)values;
- (void)removeGenotypes:(NSSet *)values;

- (void)addMiceFamilyDetailsObject:(MouseFamilyDetails *)value;
- (void)removeMiceFamilyDetailsObject:(MouseFamilyDetails *)value;
- (void)addMiceFamilyDetails:(NSSet *)values;
- (void)removeMiceFamilyDetails:(NSSet *)values;

@end
