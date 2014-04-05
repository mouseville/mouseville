//
//  Rack.h
//  Mouseville
//
//  Created by Abhang on 2/15/14.
//  Copyright (c) 2014 CapstoneProject. All rights reserved.
//

#import <Foundation/Foundation.h>
#include "RackDetails.h"

@interface Rack : NSObject

-(BOOL)addNewRack:(NSManagedObjectContext*) managedObjectContext name:(NSString*)name rows:(NSNumber*)rows columns:(NSNumber*)columns;

-(NSArray*)getAllRacks: (NSManagedObjectContext*) managedObjectContext;

-(RackDetails*) getParticularRack: (NSManagedObjectContext*) managedObjectContext rackName:(NSString*) rackName;

-(BOOL)deleteRack: (NSManagedObjectContext*) managedObjectContext rackName:(NSString*)rackName;

-(NSNumber*) : (NSManagedObjectContext*) managedObjectContext;

-(NSNumber*) getCurrentRackCount: (NSManagedObjectContext*) managedObjectContext;


@end
