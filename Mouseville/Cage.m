//
//  Cage.m
//  Mouseville
//
//  Created by Abhang on 2/15/14.
//  Copyright (c) 2014 CapstoneProject. All rights reserved.
//

#import "Cage.h"



@implementation Cage


-(CageDetails*)getParticularCage:(NSManagedObjectContext *)managedObjectContext rack:(RackDetails *)rack row:(NSNumber *)row column:(NSNumber *)column
{
   
    NSSet* cages = rack.cages;
    
    for(CageDetails* cage in cages)
    {
        if(cage.row_id == row && cage.column_id == column)
            return cage;
    }
    
    return Nil;
    
}

-(NSArray*)getLabelsForCage: (NSManagedObjectContext*) managedObjectContext cage:(CageDetails*) cage
{
    
    NSMutableSet* currentCageLabels = [NSMutableSet setWithSet:cage.labels];
    
    NSMutableSet* currentRackLabels = [NSMutableSet setWithSet:cage.rackDetails.labels];
    
    if([currentRackLabels count] != 0 && [currentCageLabels count]!=0)
    {
        [currentCageLabels intersectSet:currentRackLabels];
    }
    
    NSArray* arrayWithLabels = [NSArray arrayWithArray:[currentCageLabels allObjects]];
    
    return arrayWithLabels;
    
}


-(BOOL)deleteParticularCage:(NSManagedObjectContext *)managedObjectContext rack:(RackDetails *)rack row:(NSNumber *)row column:(NSNumber *)column cageObject:(CageDetails *)cageObject
{
    
    NSError *error = nil;
    
    for(MouseDetails* mouse in cageObject.mouseDetails)
    {
     
        
        MouseDeceasedDetails* mouseDeceased = [NSEntityDescription insertNewObjectForEntityForName:@"MouseDeceasedDetails" inManagedObjectContext:managedObjectContext];
        
        mouseDeceased.mouse_id = mouse.mouse_id;
        mouseDeceased.is_deceased = @"Yes";
        mouseDeceased.birth_date = mouse.birth_date;
        mouseDeceased.cage_id = mouse.cage_id;
        mouseDeceased.mouse_name = mouse.mouse_name;
        mouseDeceased.genotype = mouse.genotypes;
        mouseDeceased.gender = mouse.gender;
        mouseDeceased.cage_name = mouse.cage_name;
        
        if(![managedObjectContext save:&error])
        {
            NSLog(@"Error deleting Cage %@ %@", error, [error localizedDescription]);
            return NO;
        }
        
    }
    
    [managedObjectContext deleteObject:cageObject];
    if(![managedObjectContext save:&error])
    {
        NSLog(@"Error deleting Cage %@ %@", error, [error localizedDescription]);
        return NO;
    }
    
    return YES;
    
}


-(CageDetails*) editParticularCage:(NSManagedObjectContext *)managedObjectContext rack:(RackDetails *)rack row:(NSNumber *)row column:(NSNumber *)column cageObject:(CageDetails *)cageObject
{
    NSEntityDescription* cageEntity = [NSEntityDescription entityForName:@"CageDetails" inManagedObjectContext:managedObjectContext];
    
    NSFetchRequest* fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:cageEntity];
    
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"cage_id == %@ AND row_id == %@ AND column_id == %@ AND rack_id == %@ ", cageObject.cage_id,cageObject.row_id, cageObject.column_id,rack.rack_id ];
    

    [fetchRequest setPredicate:predicate];
    
    NSError* error = nil;
    
    CageDetails* cage = [managedObjectContext executeFetchRequest:fetchRequest error:&error][0];
    
    [cage setNotes:cageObject.notes];
    [cage setLabels:cageObject.labels];
    [cage setCage_name:cageObject.cage_name];
    
    if(![managedObjectContext save:&error])
    {
        NSLog(@"Unable to save cage information %@ %@",error, [error localizedDescription]);
        return nil;
    }
    
    return cage;
    
    
    
}


-(CageDetails*) addMouseToCage:(NSManagedObjectContext *)managedObjectContext rack:(RackDetails *)rack row:(NSNumber *)row column:(NSNumber *)column cageDetails:(CageDetails *)cageObject mouseDetails:(MouseDetails *)mouseDetails
{
    
    NSEntityDescription* cageEntity = [NSEntityDescription entityForName:@"CageDetails" inManagedObjectContext:managedObjectContext];
    
    NSFetchRequest* fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:cageEntity];
    
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"cage_id == %@ AND row_id == %@ AND column_id == %@ AND rack_id == %@ ", cageObject.cage_id,cageObject.row_id, cageObject.column_id,rack.rack_id ];
    
    
    [fetchRequest setPredicate:predicate];
    
    NSError* error = nil;
    
    CageDetails* cage = [managedObjectContext executeFetchRequest:fetchRequest error:&error][0];
    
    [cage addMouseDetailsObject:mouseDetails];
    
    if(![managedObjectContext save:&error])
    {
        NSLog(@"Unable to add mouse to cage %@ %@", error, [error localizedDescription]);
        return nil;
    }
    
    return cage;
    
}


-(CageDetails*)removeMouseFromCage:(NSManagedObjectContext *)managedObjectContext rack:(RackDetails *)rack row:(NSNumber *)row column:(NSNumber *)column cageDetails:(CageDetails *)cageObject mouseDetails:(MouseDetails *)mouseDetails

{
    NSEntityDescription* cageEntity = [NSEntityDescription entityForName:@"CageDetails" inManagedObjectContext:managedObjectContext];
    
    NSFetchRequest* fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:cageEntity];
    
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"cage_id == %@ AND row_id == %@ AND column_id == %@ AND rack_id == %@ ", cageObject.cage_id,cageObject.row_id, cageObject.column_id,rack.rack_id ];
    
    
    [fetchRequest setPredicate:predicate];
    
    NSError* error = nil;
    
    MouseDeceasedDetails* mouseDeceased = [NSEntityDescription insertNewObjectForEntityForName:@"MouseDeceasedDetails" inManagedObjectContext:managedObjectContext];
    
    mouseDeceased.mouse_id = mouseDetails.mouse_id;
    mouseDeceased.is_deceased = @"Yes";
    mouseDeceased.birth_date = mouseDetails.birth_date;
    mouseDeceased.cage_id = mouseDetails.cage_id;
    mouseDeceased.mouse_name = mouseDetails.mouse_name;
    mouseDeceased.genotype = mouseDetails.genotypes;
    mouseDeceased.gender = mouseDetails.gender;
    mouseDeceased.cage_name = mouseDetails.cage_name;
    
    if(![managedObjectContext save:&error])
    {
        NSLog(@"Error deleting Mouse from Cage %@ %@", error, [error localizedDescription]);
        return nil;
    }
    
    CageDetails* cage = [managedObjectContext executeFetchRequest:fetchRequest error:&error][0];
    
   
    if(cage==nil)
    {
        NSLog(@"Error retrieving cage details %@ %@",error,[error localizedDescription]);
        return nil;
    }
    
    [cage removeMouseDetailsObject:mouseDetails];
    
    if(![managedObjectContext save:&error])
    {
        NSLog(@"Error deleting Mouse from Cage %@ %@", error, [error localizedDescription]);
        return nil;
    }
    
    return cage;
}

-(CageDetails*) moveMouseToDifferentCage:(NSManagedObjectContext *)managedObjectContext rack:(RackDetails *)rack cageDetails:(CageDetails *)cageObject mouseDetails:(MouseDetails *)mouseDetails rowToMove:(NSNumber *)row columnToMove:(NSNumber *)column
{
    
    NSEntityDescription* cageEntity = [NSEntityDescription entityForName:@"CageDetails" inManagedObjectContext:managedObjectContext];
    
    NSFetchRequest* fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:cageEntity];
    
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"row_id == %@ AND column_id == %@ AND rack_id == %@ ", row,column,rack.rack_id ];
    
    NSError* error = nil;
    
    [fetchRequest setPredicate:predicate];
    
    
    CageDetails* cage = [managedObjectContext executeFetchRequest:fetchRequest error:&error][0];
    
    if(cage==nil)
    {
        NSLog(@"Error retrieving cage details %@ %@",error,[error localizedDescription]);
        return nil;
    }
    
    [cage addMouseDetailsObject:mouseDetails];
    [cageObject removeMouseDetailsObject:mouseDetails];
    
    if(![managedObjectContext save:&error])
    {
        NSLog(@"Error moving Mouse from Cage %@ %@", error, [error localizedDescription]);
        return nil;
    }

    return cageObject;
    
}

+(NSString*) numberToAlphabet:(NSNumber *)cageNumber
{
    NSString* alphabetString = @"A,B,C,D,E,F,G,H,I,J";
    NSArray* alphabetArray = [alphabetString componentsSeparatedByString:@","];
    
    return [alphabetArray objectAtIndex:(int)([cageNumber intValue]-1)];
    
}

+(NSNumber*) alphabetToNumber:(NSString *)cageLetter
{
    NSString* alphabetString = @"A,B,C,D,E,F,G,H,I,J";
    NSArray* alphabetArray = [alphabetString componentsSeparatedByString:@","];
    
    NSUInteger integerValue = ([alphabetArray indexOfObject:cageLetter]+1);
    
    NSNumber* value = [NSNumber numberWithInteger:integerValue];
    
    return value;
                          
    
    
    
    
}

@end
