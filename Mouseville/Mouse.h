//
//  Mouse.h
//  Mouseville
//
//  Created by Abhang on 2/15/14.
//  Copyright (c) 2014 CapstoneProject. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CageDetails.h"
#import "MouseDetails.h"
#import "MouseDeceasedDetails.h"
#import "RackDetails.h"



@interface Mouse : NSObject


-(BOOL) addNewMouse:(NSManagedObjectContext *)managedObjectContext mouseName:(NSString *)mouseName gender:(NSString *)gender genotypes:(NSSet *)genotypes dateOfBirth:(NSDate *)dateOfBirth rackName:(NSString *)rackName cageRow:(NSNumber*)cageRow cageColoumn:(NSNumber*)cageColumn;

-(NSArray*) miceResult: (NSManagedObjectContext*) managedObjectContext mouseName:(NSString*)mouseName gender:(NSString*)gender genotype:(NSString*)genotype weekRange:(NSArray*)ageRange;

-(MouseDetails*) editMouseDetails: (NSManagedObjectContext*) managedObjectContext mouseDetails:(MouseDetails*)mouseDetails;

-(BOOL) markMousedDeceased: (NSManagedObjectContext*) managedObjectContext mouseDetails:(MouseDetails*)MouseDetails;

-(NSNumber*) nextMouseId: (CageDetails*) cageDetails;

-(NSSet*) getPotentialParents: (CageDetails*) cageDetails;

-(NSArray*) getAllDeceasedMice: (NSManagedObjectContext*) managedObjectContext;

-(int) getWeeksFromDate: (NSDate*) date;

-(MouseDetails*) getMiceForRackCage: (NSManagedObjectContext *)managedObjectContext mouseName:(NSString *)mouseName gender:(NSString *)gender rack:(NSString*) rackName cageRow:(NSNumber*)cageRow cageColumn:(NSNumber*)cageColumn;

+(NSString *)getGenotypeString:(MouseDetails *)mouse;

@end
