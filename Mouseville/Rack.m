//
//  Rack.m
//  Mouseville
//
//  Created by Abhang on 2/15/14.
//  Copyright (c) 2014 CapstoneProject. All rights reserved.
//

#import "Rack.h"
#import "CageDetails.h"
#import "MouseDetails.h"
#import "MouseDeceasedDetails.h"

@implementation Rack

+(CageDetails *)getCageFromStringIndex:(NSString *)index inRack:(RackDetails *)rack {
    // sanity check on index
    if (index.length != 2) {
        return nil;
    }
    
    int column = [[Cage alphabetToNumber:[index substringToIndex:1]] intValue];
    
    NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
    [f setNumberStyle:NSNumberFormatterDecimalStyle];
    int row = [[f numberFromString:[index substringFromIndex:1]] intValue];
    
    // check if index within bound of the rack
    if (row > rack.number_rows.intValue || column > rack.number_columns.intValue) {
        return nil;
    }
    
    for (CageDetails *cage in rack.cages) {
        if (row == cage.row_id.intValue && column == cage.column_id.intValue) {
            return cage;
        }
    }
    
    // there was no cage with the index
    return nil;
}

+(CageDetails *)getCageFromRack:(RackDetails *)rack withRow:(int)row withColumn:(int)column {
    for (CageDetails *cage in rack.cages) {
        if (row == cage.row_id.intValue && column == cage.column_id.intValue) {
            return cage;
        }
    }
    
    // the cage with these coordinates was not found
    return nil;
}

-(BOOL)addNewRack:(NSManagedObjectContext*) managedObjectContext name:(NSString*)name rows:(NSNumber*)rows columns:(NSNumber*)columns
{
    RackDetails* rack = [NSEntityDescription insertNewObjectForEntityForName:@"RackDetails"inManagedObjectContext:managedObjectContext];
    
    if(rack!=nil)
    {
        
        
        
        NSNumber* currentCount = [self getCurrentRackCount:managedObjectContext];
        int value = [currentCount intValue];
        currentCount = [NSNumber numberWithInteger:value+1];
        rack.rack_id = currentCount;
        rack.rack_name = name;
        rack.number_rows = rows;
        rack.number_columns = columns;
        rack.created_date = [NSDate date];
        
        //set the cages to rows and columns
        
        
        int cageID = 0;
        for(int i = 1;i<=[rows intValue];i++)
        {
            for(int j=1;j<=[columns intValue];j++)
            {
                cageID++;
                CageDetails* cage = [NSEntityDescription insertNewObjectForEntityForName:@"CageDetails" inManagedObjectContext:managedObjectContext];
                
                NSNumber* row = [NSNumber numberWithInteger:i];
                NSNumber* column = [NSNumber numberWithInteger:j];
                cage.row_id = row;
                cage.column_id = column;
                cage.cage_id = [NSNumber numberWithInteger:cageID];
                cage.rack_id = rack.rack_id;
                cage.rackDetails = rack;
                [rack addCagesObject:cage];
                
            }
        }
        
        NSError *error = nil;
        if(![managedObjectContext save:&error])
        {
            NSLog(@"Cant Save! Error in  Rack Details %@ %@",error, [error localizedDescription]);
            return NO;
        }
            
    
        return YES;
    }
    
    NSLog(@"Unable to get managed context");
    return NO;
}

-(BOOL) editParticularRack:(NSManagedObjectContext*)managedObjectContext rack:(RackDetails*) rack newRackName:(NSString*)newRackName

{
    NSEntityDescription* rackEntity = [NSEntityDescription entityForName:@"RackDetails" inManagedObjectContext:managedObjectContext];
    
    NSFetchRequest* fetchRequest = [[NSFetchRequest alloc]init];
    [fetchRequest setEntity:rackEntity];
    
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"rack_name LIKE %@", rack.rack_name];
    
    [fetchRequest setPredicate:predicate];
    
    NSError* errorRequest = Nil;
    
    NSArray* rackResult = [managedObjectContext executeFetchRequest:fetchRequest error:&errorRequest];
    
    RackDetails* rackToSave = nil;
    
    if(errorRequest==nil)
    {
        for(RackDetails* individualRack in rackResult)
        {
            if([individualRack.rack_name isEqual:rack.rack_name])
            {
                rackToSave = individualRack;
                break;
            }
        }
        
        [rackToSave setRack_name:newRackName];
        
    }
    else
    {
        return NO;
    }
  
    if(![managedObjectContext save:&errorRequest])
    {
        NSLog(@"Error editing rack details %@ ", [errorRequest localizedDescription]);
        return NO;
    }
    
    else
    {
        return YES;
    }
    
}

-(BOOL) setRackLabels: (NSManagedObjectContext*) managedObjectContext rack:(RackDetails*)rack labels:(NSArray*)labels
{
    NSEntityDescription* rackEntity = [NSEntityDescription entityForName:@"RackDetails" inManagedObjectContext:managedObjectContext];
    
    NSFetchRequest* fetchRequest = [[NSFetchRequest alloc]init];
    [fetchRequest setEntity:rackEntity];
    
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"rack_name LIKE %@", rack.rack_name];
    
    [fetchRequest setPredicate:predicate];
    
    NSError* errorRequest = Nil;
    
    NSArray* rackResult = [managedObjectContext executeFetchRequest:fetchRequest error:&errorRequest];
    
    RackDetails* rackToSave = nil;
    
    if(errorRequest==nil)
    {
        for(RackDetails* individualRack in rackResult)
        {
            if([individualRack.rack_name isEqual:rack.rack_name])
            {
                rackToSave = individualRack;
                break;
            }
        }
        
        rackToSave.labels = [NSSet setWithArray:labels];
        
    }
    else
    {
        return NO;
    }

    if(![managedObjectContext save:&errorRequest])
    {
        NSLog(@"Error editing rack details %@ ", [errorRequest localizedDescription]);
        return NO;
    }
    
    else
    {
        return YES;
    }    
    
}

-(NSNumber*) getCurrentRackCount:(NSManagedObjectContext *)managedObjectContext
{
    NSEntityDescription* rackEntity = [NSEntityDescription entityForName:@"RackDetails" inManagedObjectContext:managedObjectContext];
    
    NSFetchRequest* fetchRequest = [[NSFetchRequest alloc]init];
    [fetchRequest setEntity:rackEntity];
    
    NSError* errorRequest = Nil;
    
    NSArray* racks = [managedObjectContext executeFetchRequest:fetchRequest error:&errorRequest];
    
    NSNumber* rackCount = [[NSNumber alloc]initWithInteger:[racks count]];
    
    return rackCount;
    
    
    
}

-(NSArray*)getAllRacks:(NSManagedObjectContext *)managedObjectContext
{
    NSEntityDescription* rackEntity =  [NSEntityDescription entityForName:@"RackDetails" inManagedObjectContext:managedObjectContext];
    
    NSFetchRequest* fetchRequest = [[NSFetchRequest alloc]init];
    [fetchRequest setEntity:rackEntity];
    
    NSError* errorRequest = nil;
    NSArray* racks = [managedObjectContext executeFetchRequest:fetchRequest error:&errorRequest];
    
    return racks;
}

-(RackDetails*)getParticularRack:(NSManagedObjectContext *)managedObjectContext rackName:(NSString *)rackName
{
    
    NSEntityDescription* rackEntity =  [NSEntityDescription entityForName:@"RackDetails" inManagedObjectContext:managedObjectContext];
    
    NSFetchRequest* fetchRequest = [[NSFetchRequest alloc]init];
    [fetchRequest setEntity:rackEntity];
    
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"rack_name LIKE %@",rackName];
    
    [fetchRequest setPredicate:predicate];
    
    
    NSError* error = nil;
    NSArray* racks = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    return racks[0];
    
}


//-(RackDetails*) editRack:(NSManagedObjectContext*) managedObjectContext rack:(RackDetails*)rack
//{
    
//}


-(BOOL)deleteRack:(NSManagedObjectContext *)managedObjectContext rackName:(NSString *)rackName

{
    
    
    RackDetails* rack = [self getParticularRack:managedObjectContext rackName:rackName];
    
    NSError *error = nil;
    
    for(CageDetails* cage in rack.cages)
    {
        for(MouseDetails* mouse in cage.mouseDetails)
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
                NSLog(@"Error deleting Rack %@ %@", error, [error localizedDescription]);
                return NO;
            }
            
        }
    }
    
    
    [managedObjectContext deleteObject:rack];
    if(![managedObjectContext save:&error])
    {
        NSLog(@"Error deleting Rack %@ %@", error, [error localizedDescription]);
        return NO;
    }
    
    return YES;
    
    
}

@end