//
//  GenotypeManager.m
//  Mouseville
//
//  Created by abhang on 4/6/14.
//  Copyright (c) 2014 CapstoneProject. All rights reserved.
//

#import "GenotypeManager.h"

@implementation GenotypeManager

-(BOOL)addNewGenotype:(NSManagedObjectContext *)managedObjectContext genotype:(NSString *)genotype
{
    
    GenotypeLabels* genotypeLabelEntity = [NSEntityDescription insertNewObjectForEntityForName:@"GenotypeLabels" inManagedObjectContext:managedObjectContext];

    NSError* errorRequest = nil;
    
    genotypeLabelEntity.genotypeLabel = genotype;
    
    [managedObjectContext insertObject:genotypeLabelEntity];
    
    if(![managedObjectContext save:&errorRequest])
    {
        NSLog(@"Error inserting new genotype label %@", [errorRequest localizedDescription]);
        return NO;
    }
    
    return YES;
    
    
}

-(NSArray*)getAllgenotypes:(NSManagedObjectContext *)managedObjectContext
{
    NSEntityDescription* genotypeLabelEntityt = [NSEntityDescription entityForName:@"GenotypeLabels" inManagedObjectContext:managedObjectContext];
    
    NSError* errorRequest = nil;
    
    NSFetchRequest* fetchRequest = [[NSFetchRequest alloc]init];
    
    [fetchRequest setEntity:genotypeLabelEntityt];
    
    NSArray* allGenotypeLabels = [managedObjectContext executeFetchRequest:fetchRequest error:&errorRequest];
    
    if(errorRequest == nil)
        return allGenotypeLabels;
    else
        return nil;
}

-(BOOL)updateAllGenotypes:(NSManagedObjectContext*) managedObjectContext genotypeLabelsArray:(NSArray*)genotypeLabelsArray

{
    NSEntityDescription* genotypeLabelEntityt = [NSEntityDescription entityForName:@"GenotypeLabels" inManagedObjectContext:managedObjectContext];
    
    NSError* errorRequest = nil;
    
    NSFetchRequest* fetchRequest = [[NSFetchRequest alloc]init];
    
    [fetchRequest setEntity:genotypeLabelEntityt];
    
    NSArray* allGenotypeLabels = [managedObjectContext executeFetchRequest:fetchRequest error:&errorRequest];
    
    
    for(GenotypeLabels* individualGenotypeLabel in allGenotypeLabels)
    {
        [managedObjectContext deleteObject:individualGenotypeLabel];
    }
    
    if(![managedObjectContext save:&errorRequest])
    {
        NSLog(@"Error deleting existing genotype labels!! %@", [errorRequest localizedDescription]);
        return NO;
    }
    
    for(NSString* genotypeLabelString in genotypeLabelsArray)
    {
        GenotypeLabels* genotypeLabelEntity = [NSEntityDescription insertNewObjectForEntityForName:@"GenotypeLabels" inManagedObjectContext:managedObjectContext];
        
        genotypeLabelEntity.genotypeLabel = genotypeLabelString;
        
        [managedObjectContext insertObject:genotypeLabelEntity];
        
    }
    
    if(![managedObjectContext save:&errorRequest])
    {
        NSLog(@"Error adding genotype labels!! %@", [errorRequest localizedDescription]);
        return NO;
    }
    
    return YES;
    
}


@end
