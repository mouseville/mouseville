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


@interface Cage : NSObject

-(CageDetails*) getParticularCage: (NSManagedObjectContext*) managedObjectContext rack:(RackDetails*)rack row:(NSNumber*)row column:(NSNumber*)column;

-(BOOL)deleteParticularCage: (NSManagedObjectContext*) managedObjectContext rack:(RackDetails*)rack row:(NSNumber*)row column:(NSNumber*)column cageObject:(CageDetails*)cageObject;

-(CageDetails*) editParticularCage: (NSManagedObjectContext*) managedObjectContext rack:(RackDetails*)rack row:(NSNumber*)row column:(NSNumber*)column cageObject:(CageDetails*)cageObject;

-(CageDetails*) addMouseToCage: (NSManagedObjectContext*) managedObjectContext rack:(RackDetails*)rack row:(NSNumber*)row column:(NSNumber*)column cageDetails:(CageDetails*)cageObject mouseDetails:(MouseDetails*)mouseDetails;

-(CageDetails*) removeMouseFromCage: (NSManagedObjectContext*) managedObjectContext rack:(RackDetails*)rack row:(NSNumber*)row column:(NSNumber*)column cageDetails:(CageDetails*)cageObject mouseDetails:(MouseDetails*)mouseDetails;

-(CageDetails*) moveMouseToDifferentCage: (NSManagedObjectContext *) managedObjectContext rack:(RackDetails*)rack cageDetails:(CageDetails*)cageObject mouseDetails:(MouseDetails*)mouseDetails rowToMove:(NSNumber*)row columnToMove:(NSNumber*)column;

+(NSString*) numberToAlphabet: (NSNumber*) cageNumber;
+(NSNumber*) alphabetToNumber: (NSString*) cageLetter;


@end
