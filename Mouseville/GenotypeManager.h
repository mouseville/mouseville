//
//  GenotypeManager.h
//  Mouseville
//
//  Created by abhang on 4/6/14.
//  Copyright (c) 2014 CapstoneProject. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Genotype.h"
#import "GenotypeLabels.h"

@interface GenotypeManager : NSObject

-(BOOL) addNewGenotype : (NSManagedObjectContext*)managedObjectContext genotype:(NSString*)genotype;

-(NSArray*) getAllgenotypes : (NSManagedObjectContext*) managedObjectContext;

-(BOOL)updateAllGenotypes:(NSManagedObjectContext*) managedObjectContext genotypeLabelsArray:(NSArray*)genotypeLabelsArray;

@end
