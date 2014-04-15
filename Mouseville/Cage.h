//
//  Cage.h
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

#define EMPTY_CAGE  (0)
#define MALE_ONLY   (1)
#define FEMALE_ONLY (2)
#define BREEDING    (3)

@interface Cage : NSObject

-(CageDetails*) getParticularCage: (NSManagedObjectContext*) managedObjectContext rack:(RackDetails*)rack row:(NSNumber*)row column:(NSNumber*)column;

-(CageDetails*) getParticularCage: (NSManagedObjectContext*) managedObjectContext rackId:(NSNumber*)rackId cageId:(NSNumber*)cageId;

-(BOOL)deleteParticularCage: (NSManagedObjectContext*) managedObjectContext rack:(RackDetails*)rack row:(NSNumber*)row column:(NSNumber*)column cageObject:(CageDetails*)cageObject;

-(CageDetails*) editParticularCage: (NSManagedObjectContext*) managedObjectContext rack:(RackDetails*)rack row:(NSNumber*)row column:(NSNumber*)column cageObject:(CageDetails*)cageObject;

-(CageDetails*) addMouseToCage: (NSManagedObjectContext*) managedObjectContext rack:(RackDetails*)rack row:(NSNumber*)row column:(NSNumber*)column cageDetails:(CageDetails*)cageObject mouseDetails:(MouseDetails*)mouseDetails;

-(CageDetails*) removeMouseFromCage: (NSManagedObjectContext*) managedObjectContext rack:(RackDetails*)rack row:(NSNumber*)row column:(NSNumber*)column cageDetails:(CageDetails*)cageObject mouseDetails:(MouseDetails*)mouseDetails;

-(CageDetails*) moveMouseToDifferentCage: (NSManagedObjectContext *) managedObjectContext rack:(RackDetails*)rack cageDetails:(CageDetails*)cageObject mouseDetails:(MouseDetails*)mouseDetails rowToMove:(NSNumber*)row columnToMove:(NSNumber*)column;


-(NSArray *)getAllCages: (NSManagedObjectContext *) managedObjectContext rackId:(NSNumber*) rackId;


-(NSArray*)setLabelsForCage: (NSManagedObjectContext*) managedObjectContext cage:(CageDetails*)cage labels:(NSArray*)labels;


-(NSArray*)getLabelsForCage: (NSManagedObjectContext*) managedObjectContext cage:(CageDetails*) cage;


+(NSString*) numberToAlphabet: (NSNumber*) cageNumber;
+(NSNumber*) alphabetToNumber: (NSString*) cageLetter;
+(NSString*) getStringFromIndex:(CageDetails *) cageDetails;

// This function will return EMPTY_CAGE, MALE_ONLY, FEMALE_ONLY, or BREEDING
+(int)getBreedingStatus:(CageDetails *)cage;

+(BOOL)maleInCage:(CageDetails *)cage;

@end
