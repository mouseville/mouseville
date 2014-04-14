//
//  Rack.h
//  Mouseville
//
//  Created by Abhang on 2/15/14.
//  Copyright (c) 2014 CapstoneProject. All rights reserved.
//

#import <Foundation/Foundation.h>
#include "RackDetails.h"
#import "Cage.h"
#import "Labels.h"

@interface Rack : NSObject

-(BOOL)addNewRack:(NSManagedObjectContext*) managedObjectContext name:(NSString*)name rows:(NSNumber*)rows columns:(NSNumber*)columns withLabels:(NSSet *)labels;

-(NSArray*)getAllRacks: (NSManagedObjectContext*) managedObjectContext;

-(RackDetails*) getParticularRack: (NSManagedObjectContext*) managedObjectContext rackName:(NSString*) rackName;

-(BOOL)deleteRack: (NSManagedObjectContext*) managedObjectContext rackName:(NSString*)rackName;

-(NSNumber*) getCurrentRackCount: (NSManagedObjectContext*) managedObjectContext;

+(CageDetails *) getCageFromStringIndex:(NSString *)index inRack:(RackDetails *)rack;

-(BOOL)setRackLabels: (NSManagedObjectContext*) managedObjectContext rack:(RackDetails*)rack labels:(NSArray*)labels;

+(CageDetails *) getCageFromRack:(RackDetails *)rack withRow:(int)row withColumn:(int)column;

+(Labels *) getLabelFromRack:(RackDetails *)rack withIndex:(int) index;

@end
