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

-(BOOL)addNewRack:(NSManagedObjectContext *)managedObjectContext name:(NSString*)name rows:(NSNumber *) rows columns:(NSNumber *)columns
{
    RackDetails* rack = [NSEntityDescription insertNewObjectForEntityForName:@"RackDetails"inManagedObjectContext:managedObjectContext];
    
    if(rack!=nil)
    {
        
        
        
        NSNumber* currentCount = [rack valueForKeyPath:@"count"];
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
    
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"rack_name == %@",rackName];
    
    [fetchRequest setPredicate:predicate];
    
    
    NSError* error = nil;
    NSArray* racks = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    return racks[0];
    
}

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